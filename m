From: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <bsteinbr@gmail.com>
Subject: Odd results with git-describe
Date: Wed, 6 Aug 2014 11:18:18 +0200
Message-ID: <CACPtaxbeB4fjwsKcd7SOzz2yYYUnWUYdaSc3qBoRoSjVxc6Skw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 11:18:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XExMW-0003pN-MD
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 11:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbaHFJSV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 05:18:21 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55897 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbaHFJSU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 05:18:20 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so2850922wib.11
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=yBjksSqPB6dJCloYUOya0g48LeLYTbNtfdyXXNLEEoA=;
        b=QcLAt/59rmJbDI4EH/UNLg1P1pzrEKv0QM12aGLslfcidUVAohJwGymYzN3atWbG0s
         AAIHThL5itM9ZVMLkZVgyomN54KZnB2lceAdspABuYfp1QTD6jIPMjNnH4l45lZelo4X
         k5VWALrqOA4zEaWg8Po+4stYJmYjar2aQYDHGi3NbpqNuvtnt5aULQECSLXyGp5bQz3q
         oGQtRtNTT9lJEqnpLt+/nrzYUnIdd6SiauWbcYybOW8bsjwL/e2yQtqw/U9gIx2U7dyY
         36rGQLjX2de7hvUOhXFMeGL/lX2ZfaGgOlC4Ik+yJoZ5XokeIyttACOnI1fUKtwPl6Vy
         Oy1Q==
X-Received: by 10.194.84.69 with SMTP id w5mr14508964wjy.0.1407316698649; Wed,
 06 Aug 2014 02:18:18 -0700 (PDT)
Received: by 10.216.189.9 with HTTP; Wed, 6 Aug 2014 02:18:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254850>

Hi,

with rust's git repo -- located at
https://github.com/rust-lang/rust.git -- we see odd results from
git-describe for the latest tag.

$ git rev-parse HEAD
795f6ae829ab1bfd72394a5da9096e2717ec0f62

$ git describe  --debug
searching to describe HEAD
finished search at 7140d7c52bdf55daf0b978a19706d20c3bf7ee92
 annotated       3627 0.10
 annotated       5929 0.9
 annotated       8581 0.8
 annotated      11686 0.7
 annotated      14540 0.6
 annotated      15230 0.11.0
traversed 15232 commits
0.10-3627-g795f6ae

Somehow it reports that 0.11.0 is missing tons of commits that are in
HEAD. rev-list disagrees with this:

$ git rev-list 0.11.0.. | wc -l
1155

The `SEARCH STRATEGY` section of the manpage says that the commit
numbers for describe and rev-list should match, which is not the case
here.

Bj=C3=B6rn

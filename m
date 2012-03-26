From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Merge-friendly text-based data storage
Date: Mon, 26 Mar 2012 16:19:39 +0200
Message-ID: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 16:26:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCAsd-0003VI-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 16:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549Ab2CZO0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 10:26:40 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44735 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932489Ab2CZO0i (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 10:26:38 -0400
Received: by lahj13 with SMTP id j13so3937517lah.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Y1Gi9JnKDbf06gW2aRARHGq6rVgfiPfXs911v22aM5k=;
        b=Hbp9E/CYsU8Xh0in7vTCpHWluoBjQZqH3X9+MzrOpN3xWpjZ4fnmPkDDnP6jEQ0VGh
         96PibAuEWaCrQVJqwg1ufLUcoNslNKJ6fLBju3bUtXYE6r55GCPRyiRJwVjh4E6faqpp
         hkuEVqzHhawUe5LPMuaAC1HbHN0HAUp3tIB1ziUD3dPHYmE6HNj8PMds/deijc3rz9xn
         tPZ7T87n2a+4sWGsf3KKhHrxv2X9x9qlBqNXq3CazFTsyjc76r1HhsH4EY80QktwsekW
         +wtv3otQQ1eY2UH+BsRXHwm5/gaZknKbHElroL61eCrNb9BXjtDS9GjTy2SS9X6xg0fY
         a2KQ==
Received: by 10.112.26.135 with SMTP id l7mr8012087lbg.67.1332771997485; Mon,
 26 Mar 2012 07:26:37 -0700 (PDT)
Received: by 10.112.99.233 with HTTP; Mon, 26 Mar 2012 07:19:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193913>

Hi all,

I am looking for information on how to design a merge-friendly data
layout. Oddly enough, there does not seem to be much online other than
the obvious "use text-based lines, one per data point".

My current plan looks like:

  metamonger\tversion: 0
  filename\towner_name\tgroup_name\tetc\tpp
  ##########
  file1\trichih\trichih\tfoo\tbar
  relative/path/to/file2\troot\troot\tfoo\tbar

the two upper lines are designed to fail a merge if the version of the
file layout changes. Anything starting with a hash-pound is a comment
and will be ignored.

All other lines are data about random files, relative paths being
allowed, absolute paths and upper paths being forbidden for security
reasons. Values are tab-separated as the format is expressively meant
to be edited by hand. Hex, if needed, would be ASCII-armoured.

As long as there are no lines that start with the same file name, this
file format would allow for efficient merging _if_ git has an internal
concept of line identifiers.


Are there any considerations I missed? Are there any design
guides/best practices to follow?



Thanks,
Richard

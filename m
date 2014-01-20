From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/WIP v2 08/14] read-cache: add GIT_TEST_FORCE_WATCHER for testing
Date: Mon, 20 Jan 2014 08:32:38 +0700
Message-ID: <CACsJy8BQ-Z5NtmxDhLw98q_rianK7Ny_pJLubQ8=KtmTA9g8kg@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com> <1389952060-12297-9-git-send-email-pclouds@gmail.com>
 <87lhybewcs.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Jan 20 02:33:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W53jm-00068R-Ct
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 02:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbaATBdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jan 2014 20:33:10 -0500
Received: from mail-qe0-f51.google.com ([209.85.128.51]:63714 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbaATBdJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jan 2014 20:33:09 -0500
Received: by mail-qe0-f51.google.com with SMTP id q19so1551961qeb.10
        for <git@vger.kernel.org>; Sun, 19 Jan 2014 17:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=g383JT7gPDDLKRrMd9YsJ75mZlpxC22p0XJofk4Adg4=;
        b=mFL4J+fovowlIbG31Dw8QfGjMuRty/nDay638o6XeqdBSbUNsGT8/j13/JRShN/yRm
         A/P+U+Vi8IBK0rm94yIi8MM2D/uUaTx5csROHZW1gk+JaiVleoOoorPLYlmlo71ryYd5
         qa8f4a92WkWj1uzUNatNPke3Pr9nSBzAVxjbyh2nh/1iiSPhGAfnKbuSShesC8tUq4aF
         9LdeQp7bYSC4/bKZBsAuHic3yMvEU/ARLXLGPS9e6C2O7LroLmu9pYawczHciKCADqZ/
         8/Zsbmj69WZ7NEiK1MHFzg6CKr3VIxN5oyIoWJ1bHrC7sDJpf8opxndiNlK64wiGZoiN
         wN1g==
X-Received: by 10.224.80.8 with SMTP id r8mr23945270qak.88.1390181588549; Sun,
 19 Jan 2014 17:33:08 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 19 Jan 2014 17:32:38 -0800 (PST)
In-Reply-To: <87lhybewcs.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240704>

On Mon, Jan 20, 2014 at 12:04 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> This can be used to force watcher on when running the test
>> suite.
>>
>> git-file-watcher processes are not automatically cleaned up after ea=
ch
>> test. So after running the test suite you'll be left with plenty
>> git-file-watcher processes that should all end after about a minute.
>
> Probably not a very good idea, especially in noninteractive use?  E.g=
=2E,
> a bisection through the test suite or parallel test runs on different
> commits may exhaust the available processes and/or memory.

I think we run out of inotify resources before hitting process/memory
limits. At least that's the case when running tests in parallel.

> Each test should make an effort to clean up all watchers before
> terminating.

=46or now it's hard to do this correctly. Maybe once we get the
multi-repo file watcher, we could launch one watcher per trash
directory and cleaning up would be easier.
--=20
Duy

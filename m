From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/5] fix local clone from a linked checkout
Date: Sat, 22 Aug 2015 07:39:57 +0700
Message-ID: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
References: <20150715132552.GA28574@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 02:41:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSwrr-0005HG-Lc
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 02:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbbHVAlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 20:41:01 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34025 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbbHVAlA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 20:41:00 -0400
Received: by padfo6 with SMTP id fo6so17448965pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qG4wrE3GfGW6ov2RT8h9tBTw30IrYfdhq9wFukkeA+w=;
        b=FKK4IHWrUvf4DJM6Y+I/NSudbF9N/8ZSA6k64E+tPWNKymK8CwDBOWwopmxS08s/Dq
         SBWqoBH7QyKj3learvn7ZiioX5Qscvsoze4Jcz84Npl4SZ4XjtaRFlO6qMCvp+PfBhuZ
         Y8ku2lWo39UixEFZkQaVZSjo2Xi/byGbadoGVpaKnsXVyIfLG3aw+k1FKW0TCwMoY7le
         UDdq44TIVPNjbTkAV7iY2mAlj66I4VQ8CPj+3Ma3pIZqNHfwzJ0CEDD6DMh7BBKxqA3j
         xP3tRxkrx6VFq0JCKGEvxtHz3X/BuhINBxm7uDHgRsSFDI76mXrjULM4v36VBx7j7Spl
         w/5w==
X-Received: by 10.66.248.72 with SMTP id yk8mr21242798pac.112.1440204059973;
        Fri, 21 Aug 2015 17:40:59 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id k3sm9128620pdp.17.2015.08.21.17.40.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 17:40:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 07:40:56 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <20150715132552.GA28574@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276346>

On Wed, Jul 15, 2015 at 8:25 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jul 15, 2015 at 11:40:18AM +0200, Bj=C3=B8rnar Snoksrud wrote=
:
>> I reported this before, but now I have a nice topic to hang it on -
>>
>> I have re-reproduced the bug using a build from master as of today,
>> using the new worktree commands.
>
> Something like the following patch should work if you need it now.
>
> Because this may conflict (in the test cases) with Eric's series to
> move "git checkout --to" to "git worktree add", and because the next
> release is already delayed to let "git worktree add" in, I think we
> could keep this patch out of tree for now. I will split it up, add
> tests and resubmit once the release is out. Please remind me if you
> see nothing from me for too long.

Here it is. Mostly the same as the previous patch except that the last
patch is new.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  path.c: delete an extra space
  enter_repo: avoid duplicating logic, use is_git_directory() instead
  enter_repo: allow .git files in strict mode
  clone: allow --local from a linked checkout
  clone: better error when --reference is a linked checkout

 builtin/clone.c         | 13 ++++++++++---
 path.c                  | 14 +++++++++-----
 t/t2025-worktree-add.sh |  5 +++++
 3 files changed, 24 insertions(+), 8 deletions(-)

--=20
2.3.0.rc1.137.g477eb31

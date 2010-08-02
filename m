From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 12/16] subtree: rewriting outgoing commits
Date: Sun, 1 Aug 2010 22:40:01 -0600
Message-ID: <AANLkTim8mzhvm8unh4SKDJu60ZK4n+WWka-9WSH7yHGF@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<1280593105-22015-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 06:40:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofmp6-0003YB-8k
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 06:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab0HBEkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 00:40:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64296 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab0HBEkR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 00:40:17 -0400
Received: by wwj40 with SMTP id 40so3451515wwj.1
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 21:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u0v1Z2Xbs8/4qIKK+tfS5PmboHW1LYhPuu+HhltBR2I=;
        b=e7Vvmt+moMvc+BVxMYQ7iajS86QUwfx2FejO42nzJDSMAvlTXslEblrLsjkocLyroi
         oApzigi1autZtG3zkqDdmKkadXePltEoFI8wxLOzr8+VOVwC9xG44TwjLpBBjAiWIK2o
         T7M5iLNCRggMu9WOyfHqObj2XILUYFqLQ3bWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EKn3HNfMKqjyYWEocpAO8EMiwr/QTRAgpWvT4Sx7K1E77z9L5wihTWVcJUvDD+lviZ
         KgEBGc8JxY9tMSx0Xoqsc/hiHFsQC70qbzXMbEgTQ63qc0Z4Sv9ybN6YauiWhnD2k+B7
         fasTE37HRryQaHR3JCknyHEvfO4r2JFVYgMik=
Received: by 10.216.137.101 with SMTP id x79mr4418209wei.48.1280724002016; 
	Sun, 01 Aug 2010 21:40:02 -0700 (PDT)
Received: by 10.216.132.8 with HTTP; Sun, 1 Aug 2010 21:40:01 -0700 (PDT)
In-Reply-To: <1280593105-22015-13-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152394>

2010/7/31 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
<snip>
> + =C2=A0 =C2=A0 =C2=A0 init_tree_desc(&desc, tree, size);
> + =C2=A0 =C2=A0 =C2=A0 strbuf_init(&buffer, 8192);
> + =C2=A0 =C2=A0 =C2=A0 while (tree_entry(&desc, &entry)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&buffe=
r, "%o %.*s%c", entry.mode, strlen(entry.path), entry.path, '\0');

Again, gcc here complains that "subtree.c:390: warning: field
precision should have type =E2=80=98int=E2=80=99, but argument 4 has ty=
pe =E2=80=98size_t=E2=80=99" --
typecast the return value of strlen to int?

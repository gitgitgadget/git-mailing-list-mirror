From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] branch.c: simplify chain of if statements
Date: Mon, 17 Mar 2014 13:53:19 +0100
Message-ID: <CACBZZX6P38BEQ15w1nVh9cM6nMj0dq-HtT1ZJFfZadriXjZReA@mail.gmail.com>
References: <1395004962-18200-1-git-send-email-dragos.foianu@gmail.com>
 <CAPig+cTodcfSVmHZeHuAj2kuE_CxuZqZuaNHv33hrhDmQuSmuA@mail.gmail.com> <loom.20140317T120153-546@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 13:53:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPX35-0006aD-7z
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 13:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019AbaCQMxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 08:53:42 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:59387 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932794AbaCQMxk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 08:53:40 -0400
Received: by mail-ob0-f172.google.com with SMTP id wm4so5440346obc.17
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qPMLXcHjhFISM+FIzVYo8l14lp+8fi43OJZUif9yLnw=;
        b=znL17DbdoAnNOr+Jj0IXVIu07aENw8iQdRdRIjOSAXAJDVceEqEPGfp4Hy+AlmBs4p
         utq60/EXPsOlvDtRqXfjpUPbkJf1F9NQlNqTX50I1XP/TGUOXbAOVmx/onuDX8aVSjRO
         a2ihf1VXvVfVhmVh2nZYdLK24i0emQVLTAyfrGjk0sznjVMHB/tzGEspMGqJWHtL9gaN
         VtLxg/am43RMkmqKCfkFrE+RYQGfRtBMtibTlk6gI8gjnKBxJabhp4yMLtjxc5H3bZ04
         TjeEJJQzJ23xYGTFuiQlUD3XUcDRlBhipJQnjX9aECBenVYbb5lOEvQLP/NpVMtZPoQI
         lGJg==
X-Received: by 10.182.150.40 with SMTP id uf8mr20707460obb.19.1395060819667;
 Mon, 17 Mar 2014 05:53:39 -0700 (PDT)
Received: by 10.76.33.161 with HTTP; Mon, 17 Mar 2014 05:53:19 -0700 (PDT)
In-Reply-To: <loom.20140317T120153-546@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244247>

On Mon, Mar 17, 2014 at 12:46 PM, Dragos Foianu <dragos.foianu@gmail.co=
m> wrote:
> The reason I did not go with this is because I would still need the f=
our ifs
> in order to keep the bug check part of the code. I might be able to f=
ind a
> work-around for it on the second attempt.
>
> I have seen N_() used in other code but I wasn't sure what its purpos=
e was.

Aside from other comments here, more generally if you see code that
looks odd it helps to see why it was introduced initially.

In this case if you'd ran e.g.:

    git log --reverse -p -G'Branch %s set up to track remote branch %s
from %s by rebasing' -- branch.c

or otherwise searched for the first occurrence of that odd-looking
code you'd have gotten:

    commit d53a3503
    Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>
    Date:   Thu Jun 7 19:05:10 2012 +0700

    Remove i18n legos in notifying new branch tracking setup

    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

And searching for that commit has plenty of context for why that was
done: https://www.google.com/search?q=3D%22Remove%20i18n%20legos%20in%2=
0notifying%20new%20branch%20tracking%20setup%22

From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [EGIT] Checking out signed tags fails
Date: Tue, 16 Sep 2008 20:48:01 +0200
Message-ID: <2c6b72b30809161148p2b4ce08fh32ff5717ca85e773@mail.gmail.com>
References: <gaoaif$2up$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Jonas_Flod=E9n?=" <jonas.floden@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:49:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kffbw-0004Z4-C9
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 20:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbYIPSsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 14:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbYIPSsF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 14:48:05 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:42233 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbYIPSsD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2008 14:48:03 -0400
Received: by gxk9 with SMTP id 9so28175510gxk.13
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Shtw9mMr/7UKMK8TSG00NqBkq3UJrgZFoi/AINwsppE=;
        b=slCzEq3ssE7IBQdOkniOS4U9Cs4E+vE1/sjIZkfYDyvPVVspdvtc39qJ2JWFoWwERe
         /ru3+tJC6eFZ2CZou3k5CFAWoE34At/wUaSGv9lBIYUyNNwFAwOp/SKJPv2msRD7Znuo
         QLOIEJEu94rty+K7LvRSkQuoWyEK7jYimQKGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=a3TlmXlNnyl+lO9WYKEslF2oJZc5//tJpxmuM1kmbdT1Uyf/wpuJjKRWDB16uJVRd6
         37/cZvg7qcn1xmodbQYfYXwUAQn++V7wmrxdVBDaBjtWU+nn9sWogDVqftJ54dZdDWTg
         R4tcyLbGXlgbjs7UclR5rzirvLVmCVWc7qXMM=
Received: by 10.142.132.2 with SMTP id f2mr228780wfd.19.1221590881304;
        Tue, 16 Sep 2008 11:48:01 -0700 (PDT)
Received: by 10.142.153.19 with HTTP; Tue, 16 Sep 2008 11:48:01 -0700 (PDT)
In-Reply-To: <gaoaif$2up$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96025>

On Tue, Sep 16, 2008 at 14:58, Jonas Flod=E9n <jonas.floden@gmail.com> =
wrote:
> When trying to check-out a signed tag I get the following Error:
> Unable to switch branches
>
> Reason:
>  Mapping commit: refs/tags/v1.3.1.1
>
> And in details:
> Object XXX is not a commit.
>
> The object ID shown is actually the id for the tag object and not the
> tagged commit.
>
> This was tested with the latest master. It seemed commit 1f460e2 (Tes=
ts
> and fixes for dereferencing tags in Repository.resolve(), 2008-09-12)
> would fix it, but it didn't.

The fixes are only for the code path where reference expressions needs
to be resolved. From what I understand, the problem you have
encountered is due to resolve() falling back to using resolveSimple()
which doesn't dereference any tags. Perhaps EGit could postfix ^{} or
^{commit} to the tag name before calling mapCommit(), or whatever it
uses?

--=20
Jonas Fonseca

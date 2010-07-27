From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] tests: implicitly skip SYMLINKS tests using
 <prereq>
Date: Tue, 27 Jul 2010 16:17:37 -0500
Message-ID: <20100727211737.GA11768@burratino>
References: <1280265254-19642-1-git-send-email-avarab@gmail.com>
 <1280265254-19642-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:18:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrYB-0001Bt-D2
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab0G0VSy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 17:18:54 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62729 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab0G0VSx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:18:53 -0400
Received: by ewy23 with SMTP id 23so1485595ewy.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dziVnCCgCfmTJqF2dEp8JZpwqs3g7X8vi1XmYRiXNks=;
        b=UcmQRJQEOU/3NNLszsN7/8OtWM4/lK7Z9g8LvWLYmXvw28fPEjYAlN/FnmLlKIDXir
         zL7l1y5JWVwVxiHFxzt1VtQjfr2dFv9VNH2npDUZDJutsReu5DJRVpmtLlRbfbXrQt4b
         V/vjMNXwqc+bS69OXqtHLsgrarDQv1H++/sDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jhn5htmDN+IOBIBZxu+IC4fBA5xNY7OBZnMTgDVgQX1ehk39njAS83tCQf/WBPLWgo
         hQsUpSK4JmpVS8blqg1gJUlfOrFMun7y1m5GL2XaBrt92S4ysAJRDsr149+VSLFfKJJQ
         JDuXwuJ7imAN2E2y421/VEPlWBziYsrzRM57Q=
Received: by 10.213.19.211 with SMTP id c19mr7485386ebb.93.1280265532393;
        Tue, 27 Jul 2010 14:18:52 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v59sm8257034eeh.22.2010.07.27.14.18.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 14:18:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280265254-19642-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151999>

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> +++ b/t/t4004-diff-rename-symlink.sh
> @@ -40,8 +34,9 @@ test_expect_success \
>  # rezrov and nitfol are rename/copy of frotz and bozbar should be
>  # a new creation.
> =20
> -GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >current
> -cat >expected <<\EOF
> +test_expect_success SYMLINKS 'setup diff output' "
> +    GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >curren=
t
> +    cat >expected <<\EOF
>  diff --git a/bozbar b/bozbar
>  new file mode 120000
>  --- /dev/null

Probably belongs in a separate patch.  More importantly, it is missing
&&-chaining (not a regression, but it is best to set a good example).

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix git-apply with -p greater than 1
Date: Fri, 22 Oct 2010 00:31:40 -0500
Message-ID: <20101022053140.GB786@burratino>
References: <1287699122-26702-1-git-send-email-fedux@lugmen.org.ar>
 <7viq0urfbz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Federico Cuello <fedux@lugmen.org.ar>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 07:35:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9AHt-0004z4-5h
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 07:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab0JVFf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 01:35:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64293 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab0JVFf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 01:35:26 -0400
Received: by yxn35 with SMTP id 35so323858yxn.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 22:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6oeSr3VyvJjuW7QDLXgeLoLocmvY5FvuXbFw6PSCKrM=;
        b=E1g4BTkCmiwH/7OpBfDshttOy90pbj9rhEzsfnT6ZwnUk9S952qVQJUPTkqVVdv2uU
         xfRgmUNoSfeDFMgYW/x+NhZwKUqGQAZYQSKrnimWF8G0cVmPX53eRvZTlhrC3EDWV1Be
         mTaEetRIuPMfmbg4hpRrSfoEFLH22mlKiGufs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q0Hz8uZQ1wchdKONzZI/PnV7PoK6FXqcNIcANAqjpnsUxy3xPMDa/fCJQXrLt/yDuB
         Z1SRTVPodHM1ywVg83Uvm5VhpWwfS6+EjWTKBfiVPBCZ7A4yzULhlI2jku2QX9fAV9MS
         nWdpXOwf2kMQyjsLEX5ccIz3uTD4cpWpI+zws=
Received: by 10.151.38.21 with SMTP id q21mr1437353ybj.403.1287725726153;
        Thu, 21 Oct 2010 22:35:26 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v9sm8734173ybe.9.2010.10.21.22.35.24
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 22:35:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viq0urfbz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159646>

Junio C Hamano wrote:

> +test_expect_success 'apply (-p2) diff, mode change only' '
> +	cat >patch.chmod <<-\EOF &&
> +	diff --git a/sub/file1 b/sub/file1
> +	old mode 100644
> +	new mode 100755
> +	EOF
> +	chmod 644 file1 &&
> +	git apply -p2 patch.chmod &&
> +	test -x file1

I had thought -p was only supposed to apply to traditional patches.
Maybe a documentation update would avoid confusion?

	-p<n>
	   Remove <n> leading slashes from traditional diff paths.
	   The default is 1.

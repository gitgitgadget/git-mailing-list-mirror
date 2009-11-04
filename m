From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 15:50:10 +0100
Message-ID: <16cee31f0911040650s3eba1067mb66a48bb50c97c28@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <4AF175E8.7020400@viscovery.net>
	 <16cee31f0911040547m69e5b9cbi30e20d2a7790bd6f@mail.gmail.com>
	 <4AF190F1.3020607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 15:51:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5hCN-0001dZ-FM
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 15:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067AbZKDOuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 09:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046AbZKDOuI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 09:50:08 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55453 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659AbZKDOuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 09:50:06 -0500
Received: by yxe17 with SMTP id 17so6383070yxe.33
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wv1JIEsNx0sikR8B08MXUccHwumITxIblMH5UmJ3Jek=;
        b=ax+4Qz7L6n4PixnJYQFcJbngY+3FoAxWoIiMYB+tMBHxTgYWf8MaAgJ/XVwUJlFRkq
         0mCUwaGn0DpENP2mQiHQ7P54kV11RPSDlBCgTaZz4xc+3Nz/IIsYg5NxPwPI8lEHzb1B
         YHc30HU8A0BSoHusfsUURREvh6rCLDNJ2M4eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CMwqQhKbsgsxQln4EL+wcgk69pywQez0QD+67u+vjt/o4FvKeeW9/gUNTQNuwRnEa7
         GerG2pRL3NtGfHcYQFxOhDR0zGNpglP4EDRCxj624wHsymuutMOlZBMIiSdf+WKkagMR
         KIc7IlqUmvSM1RI4fNK9tSVn+KJLhpfp9KjtU=
Received: by 10.239.163.205 with SMTP id q13mr170416hbd.132.1257346210611; 
	Wed, 04 Nov 2009 06:50:10 -0800 (PST)
In-Reply-To: <4AF190F1.3020607@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132090>

2009/11/4 Johannes Sixt <j.sixt@viscovery.net>:
>
> You are right. But #ifdef THREADED_DELTA_SEARCH is about a "generic"
> property of the code and is already used elsewhere in the file, whereas
> #ifdef WIN32 would be new and is is about platform differences.
>
> Anyway, we would have to see what Junio says about the new function calls,
> because he's usually quite anal when it comes to added code vs. static
> initialization. ;)

I could do it with wrappers for pthread_mutex_lock and _unlock and
lazy init there plus lazy init cond var in cond_wait and _signal, that
way it could be done without any additional code in the first #ifdef.
But I don't see any simple solution for working around
deinitialization, that's why I'd leave non-static initialization. Let
me put some touchups and resubmit for another round.

--
Andrzej

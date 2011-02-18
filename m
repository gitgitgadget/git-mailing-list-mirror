From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] submodule: no [--merge|--rebase] when newly cloned
Date: Thu, 17 Feb 2011 19:34:39 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102171929200.14950@debian>
References: <1297860417-21895-1-git-send-email-olsonse@umich.edu> <7v62sjkbbi.fsf@alter.siamese.dyndns.org> <4D5CC9C9.60705@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Spencer E. Olson" <olsonse@umich.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:35:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEJP-0003B6-1W
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091Ab1BRAep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:34:45 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42240 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758075Ab1BRAeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:34:44 -0500
Received: by vxb37 with SMTP id 37so1558310vxb.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 16:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=F8iYPieRLOakZcXTbagM9YNttqC4UWHZkuht/Bu/cR8=;
        b=PQfalMFlhk0INFejDqFY+sQ2TqtidQ6tZNnhH+CqXuq8CYw85gWOqMLsCr3jS4IO6F
         fkakTMJv15gUdlZSugfV28LxXIQrQOAfxngBsCHa9Mp8t+w9/EJ6h0rnu/2kc3OQtjET
         Zz/htYqUpNTAW2zSqROKBxlWZuPqiKY30xd9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=WJO8F648bKZszoCOzfiObtv55IjXK83kjhJmaOMdWTifvaS/hG+hlsLt0jDJyIrGAf
         86zhK8M5BgllASHCu6kwwX5N5jytkHfjwMSenPYwkACWZCNLcwsoX8ovajk1CEdkpc89
         25hMuuKa3QNdjeacIcyStlfuPsujSouTwCiHc=
Received: by 10.52.157.7 with SMTP id wi7mr125373vdb.176.1297989283457;
        Thu, 17 Feb 2011 16:34:43 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y15sm757240vch.29.2011.02.17.16.34.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 16:34:42 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <4D5CC9C9.60705@viscovery.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167141>

On Thu, 17 Feb 2011, Johannes Sixt wrote:

> Am 2/16/2011 20:51, schrieb Junio C Hamano:
> > Here is how to write the above more concisely, efficiently and portably.
> > 
> > 	case "$2;" in
> >         *";$1;"*)
> >         	echo yes ;;
> >         *)
> >         	echo no ;;
> > 	esac
> > 
> > The trailing ';' takes care of the case where cloned_modules has only one
> > element, in which case you have ";name" in "$2".  No need for a loop.
> 
> And while you are here, you could make this:
> 
> list_contains()
> {
> 	case "$2;" in
> 	*";$1;"*)
> 		: yes ;;
> 	*)
> 		! : no ;;
> 	esac
> }
> 
> and test for the exit code of this function rather than its output at the
> call site.

According to Brandon Casey: "Some platforms (IRIX 6.5, Solaris 7) do
not provide the 'yes' utility." See 8648732 (t/test-lib.sh: provide a
shell implementation of the 'yes' utility, 2009-08-28).


/Martin

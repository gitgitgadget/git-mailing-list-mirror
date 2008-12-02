From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Tue, 2 Dec 2008 02:53:06 +0100
Message-ID: <200812020253.09430.jnareb@gmail.com>
References: <Message-ID: <cb7bb73a0811291731g7f8770f7p89e924c00d2ab004@mail.gmail.com> <cb7bb73a0811291731g7f8770f7p89e924c00d2ab004@mail.gmail.com> <1228008844-12506-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KTB-0004s2-2M
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbYLBBxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbYLBBxP
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:53:15 -0500
Received: from ik-out-1112.google.com ([66.249.90.181]:53572 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbYLBBxO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2008 20:53:14 -0500
Received: by ik-out-1112.google.com with SMTP id c29so2277080ika.5
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pEcROZr233TlizMG5ku0G8/gBpW9OilYH2kWbg1NpC4=;
        b=jWXXY8+YAr9vMStZgia1Ge6hE55o8HK1KdBezc8vRHGreRJ1SmIRi2PkNlu/djxmYp
         JoY1dak5SeZNSPAHGXG1jLENvkEbpEYyQ/PozmNrZ4SleBTqEsVE+55d44SLHdSv2nmz
         U9Gqp/EvFcS8hN2gaNujZ9oCyl5WkGFqt+nfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AVasDF2yQJG//cZCCOic/hjfbDxS904ThvU5KlXUtPV0xD637qf/vY2bUn8Ucol8Aq
         5ndcuIZjkAeQnC37ET7xEWrJpwuqv78faaIwbjB7/J+jsrwEwZAiU8eDD6FTgxBBt9R6
         QvBMqFYZ7HJIdC0dJ2NHw10sx7gtAO2eHQRnA=
Received: by 10.210.49.19 with SMTP id w19mr13372395ebw.149.1228182791970;
        Mon, 01 Dec 2008 17:53:11 -0800 (PST)
Received: from ?192.168.1.11? (abvo94.neoplus.adsl.tpnet.pl [83.8.212.94])
        by mx.google.com with ESMTPS id z33sm4378645ikz.4.2008.12.01.17.53.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 17:53:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1228008844-12506-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102096>

On Sun, 30 Nov 2008, Giuseppe Bilotta wrote:

> The gitweb_check_feature routine was being used for two different
> purposes: retrieving the actual feature value (such as the list of
> snapshot formats or the list of additional actions), and checking if a
> feature was enabled.
> 
> This led to subtle bugs in feature checking code: gitweb_check_feature
> would return (0) for disabled features, so its use in scalar context
> would return true instead of false.
> 
> To fix this issue and future-proof the code, we split feature value
> retrieval into its own gitweb_get_feature()function , and ensure that

  retrieval into its own gitweb_get_feature() function, and ensure that

> the boolean feature check function gitweb_check_feature() always returns
> a scalar (precisely, the first/only item in the feature value list).
> 
> Usage of gitweb_check_feature() across gitweb is replaced with
> gitweb_get_feature() where appropriate, and list evaluation of
> gitweb_check_feature() is demoted to scalar evaluation to prevent
> ambiguity. The few previously incorrect uses of gitweb_check_feature()
> in scalar context are left untouched because they are now correct.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>


What I like about having all this, i.e. fix, futureproof and style
correction in one single patch is the fact that fix doesn't introduce
strange looking (gitweb_check_feature('bool_feat'))[0]... well, except
encapsulated in a subroutine.

>From all possible splits of this feature into series of up to three
patches I think I like the one with pure subroutine rename from *check*
to *get* least...
-- 
Jakub Narebski
Poland

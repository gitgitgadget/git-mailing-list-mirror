From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 06:38:24 +0200
Message-ID: <48B4DA40.1040406@gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>	<48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>	<E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>	<7vbpzgb94q.fsf@gitster.siamese.dyndns.org>	<E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net>	<7vsksrad7o.fsf@gitster.siamese.dyndns.org> <48B44C61.2020206@gnu.org>	<7vabez2yac.fsf@gitster.siamese.dyndns.org>	<7v3akr2xa3.fsf@gitster.siamese.dyndns.org> <quack.20080826T2005.lthzlmz2m4g@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Wed Aug 27 06:40:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYCpj-00049b-Pa
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 06:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbYH0Eib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 00:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbYH0Eib
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 00:38:31 -0400
Received: from qb-out-0506.google.com ([72.14.204.226]:39894 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbYH0Eia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 00:38:30 -0400
Received: by qb-out-0506.google.com with SMTP id f11so218392qba.17
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=wAvyi+iDwnN6YOR47utv7K6gd3OdmCMEsVuhyuzCUv0=;
        b=J4VSEUapmww2uAdt3Y23quwKvqbvbKK9dQbiMquIrfbTWpzxzdBzaeX3kWq3lWAYgG
         iVH8iOGOnkbRcTxfrZGWIeC3sfeWmciaL0M2KiQKa87gnlZDsqENj9vqpbYaUPA3S8XA
         K1jmu17zeH/2C7233hE+jaTQumqQxG2vP8t+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=WoTPAbiNP43xriIpP8Z075lKBAHGtMXp1a6veBF+yuvWazKUFZSs6Aup3USY2NHh9R
         1StR/st5rJGw8DNtwEBbf7p+nXzOlYUhp60LkWOFOhPW+MrA8Pf5LMYdxHG4JfuuGhdS
         c9tuTQk0Ew/WU6L1K3WuNnXQFt7oZcLT1CeJ4=
Received: by 10.103.229.19 with SMTP id g19mr4325201mur.19.1219811909166;
        Tue, 26 Aug 2008 21:38:29 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id w5sm37771178mue.10.2008.08.26.21.38.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 21:38:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <quack.20080826T2005.lthzlmz2m4g@roar.cs.berkeley.edu>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93852>


> Yes, I can work around this issue with sh -c 'git fetch
> 0</dev/null', and maybe it shouldn't close(0) in the first place.
> But I don't see the harm in being safe.  It's one less potential
> surprise for users.  This is the first program I've encountered
> that broke due to stdin being closed

Not really.  I suspect every program that uses pipe/dup to fork a child
could be wrong (the only one I ever wrote breaks), and I wonder if the
higher-level popen(3) interface works properly.

Paolo

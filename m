From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/6] GITWEB - Separate defaults from main file
Date: Wed, 16 Dec 2009 03:22:27 +0100
Message-ID: <200912160322.28146.jnareb@gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <200912112353.11034.jnareb@gmail.com> <7v8wd3ww4d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog9@kernel.org>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 03:22:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKjXA-0006PF-Dz
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 03:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934524AbZLPCWb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2009 21:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934516AbZLPCWb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 21:22:31 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:33264 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbZLPCWa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 21:22:30 -0500
Received: by fxm21 with SMTP id 21so510990fxm.21
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 18:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lhrJqmpNNl3TOX/Pbf6a2DMYmakC1nANjB3WdnQJugI=;
        b=jrF1XdnWpCPKyjOx72ZfvkfE/Yq3aERkZO/WJ9/JnKmgj2keru/CrsnJJKnjJsWyti
         mMqoYRHxGCVTX03fidkD1p2wrYqIerEnq7UvRMIzRj+6QdXj2QJoS8r9G5+etQKhZ6qo
         WSozuEd0UMc/XgYtA2c3fzkHIh/q0FES6IDKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fD2sPCSFg2XuuqJOZ+X6tiXtkeGh/DnMajlYXx1PKOoTfgzkhQlyJW8Gl1fitGWOfu
         +YlRqrC9axFduwqouEYaVFUoz6TvIBX6ABUgYJv+5MLweiXOs1xEz0EkRIHR6efNeRLm
         LUHk7WNJStL3Q1Au2u8xcA8rIT01fxHM19a90=
Received: by 10.87.64.6 with SMTP id r6mr555161fgk.48.1260930148150;
        Tue, 15 Dec 2009 18:22:28 -0800 (PST)
Received: from ?192.168.1.13? (abwf113.neoplus.adsl.tpnet.pl [83.8.229.113])
        by mx.google.com with ESMTPS id e3sm10109392fga.11.2009.12.15.18.22.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Dec 2009 18:22:26 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8wd3ww4d.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135317>

On Wed, 16 Dec 2009, Junio C Hamano wrote:

> Not that I am anxious to queue new topics to 'next' right now (we are
> frozen for 1.6.6), but I think having what is proven to work well at =
a
> real site like k.org is much better than waiting for an unproven
> reimplementation using somebody else's framework only for your theore=
tical
> cleanliness. =A0John has better things to do than doing such a rewrit=
e
> himself, and even if you helped the process by producing a competing
> caching scheme based on existing web caching engines, the aggregated
> result (not just the web caching engine you base your work on) needs =
to
> get a similar field exposure to prove itself that it can scale to the=
 load
> k.org sees, which would be quite a lot of work, no?

I'm not against (well, not much against) custom caching that kernel.org
uses, but I am against large change to gitweb code currently accompanyi=
ng
caching, namely gather then output solution, which would negatively=20
affect performance when caching is turned off.

Also I'd like to have caching code (the one that didn't made it to git
mailing list for some reason, probably vger anti-SPAM filter) cleaned u=
p
for submission: remove commented-out code, reduce code duplication,=20
separate dealing with orthogonal issues (cache itself, adaptivity of ca=
che,
background generation and 'in progress' info, generating key for cache
(and improve key generation to include path_info / use %input_params)),
follow the same style that gitweb itself uses.

As for the "[PATCH 6/6] GITWEB - Separate defaults from main file" patc=
h,
it would require modifying gitweb tests to use generated gitweb/gitweb.=
cgi
rather than source gitweb/gitweb.perl.


As for having caching code tested by git.kernel.org: IIRC there was iss=
ue
with it not having cache expiration thus gathering GB of cached data.
--=20
Jakub Narebski
Poland

From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Sat, 13 Jun 2009 13:22:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.0906131318480.10804@yvahk2.pbagnpgbe.fr>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com> <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com> <20090612084209.6117@nanako3.lavabit.com> <alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr> <ca433830906121626q52c15f6cjdb91ffee1f2d8652@mail.gmail.com>
 <7vk53h3rey.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mark Lodato <lodatom@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 13:21:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFRIH-0007HC-GJ
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 13:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbZFMLUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 07:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbZFMLUw
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 07:20:52 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:46627 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZFMLUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 07:20:51 -0400
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n5DBKhJS001342;
	Sat, 13 Jun 2009 13:20:43 +0200
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <7vk53h3rey.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121497>

On Fri, 12 Jun 2009, Junio C Hamano wrote:

> I think what Daniel is suggesting is to attempt making a test connection 
> (that does not have to have anything to do with the real object transfer) 
> without passphrase to see if it fails.  If it doesn't, you know you do not 
> need a passphrase to unlock the key/cert.

Exactly.

Also note that (in response to Mark's other comments) you really should not go 
"beneath" libcurl, and use the SSL library directly without careful 
considerations since libcurl can be built to use one out of many SSL libs so 
it's far from sure that you're actually using OpenSSL. Or GnutTLS. Or NSS. 
Or...

If libcurl itself is not enough to solve the issue, I would probably claim 
that it would be wise to consider making libcurl support it so that the API 
remains SSL-lib agnostic to the app (git).

-- 

  / daniel.haxx.se

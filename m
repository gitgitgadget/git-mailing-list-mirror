From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 14:02:05 +1300
Message-ID: <47856E8D.4010006@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 10 02:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JClog-0008UP-8c
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 02:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbYAJBCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 20:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbYAJBCO
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 20:02:14 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:37644 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbYAJBCN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 20:02:13 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 8435021D185; Thu, 10 Jan 2008 14:02:11 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 2911A21D183;
	Thu, 10 Jan 2008 14:02:07 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LSU.1.00.0801092328580.31053@racer.site>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70030>

Johannes Schindelin wrote:
> No new object type.  Why should it?  But it has to have a config variable 
> which says what type of packs/loose objects it has (and you will not be 
> able to mix them).

I meant loose object.  However this is configured, it affects things
like HTTP push/pull.  Configuring like that would be a bit too fragile
for my tastes.

>> Not really worth it IMHO - gzip is already fast enough on even the most 
>> modern processor these days.
> 
> I agree that gzip is already fast enough.
> 
> However, pack v4 had more goodies than just being faster; it also promised 
> to have smaller packs.  And pack v4 would need to have the same 
> infrastructure of repacking if the client does not understand v4 packs.

Ineed - I think it would be a lot easier to implement if it didn't
bother with loose objects.  It can just be a new pack version with more
compression formats.  For when you know you're going to be doing a lot
of analysis you'd already run "git-repack -a -f" to shorten the deltas,
so this might be a useful option for some - but again I'd want to see
figures first.

I do really like LZOP as far as compression algorithms go.  It seems a
lot faster for not a huge loss in ratio.

Sam.

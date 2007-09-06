From: Junio C Hamano <gitster@pobox.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Thu, 06 Sep 2007 10:49:14 -0700
Message-ID: <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709061651550.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:49:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITLTu-0002qy-CJ
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbXIFRtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbXIFRtX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:49:23 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbXIFRtW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:49:22 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B7DE412F985;
	Thu,  6 Sep 2007 13:49:37 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709061651550.28586@racer.site> (Johannes
	Schindelin's message of "Thu, 6 Sep 2007 16:54:56 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57915>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 5 Sep 2007, Junio C Hamano wrote:
>
>> @@ -20,6 +20,7 @@ static const char builtin_gc_usage[] = "git-gc [--prune] [--aggressive]";
>>  
>>  static int pack_refs = 1;
>>  static int aggressive_window = -1;
>> +static int gc_auto_threshold = 6700;
>
> Please don't do that.
>
> When you share objects with another git directory, git-gc --auto can get 
> rid of the objects when some objects go away in the referenced repository.  

I thought the whole point of "gc --auto" was to have something
that does not lose/prune any objects, even the ones that do not
seem to be referenced from anywhere.  That is why invocations of
"git gc --auto" do not say --prune as you saw the second patch,
and the repack command "gc --auto" runs is "repack -d -l"
instead of "repack -a -d -l", which means that it does run
git-prune-packed after repacking but not git-prune.

Maybe I am missing something...

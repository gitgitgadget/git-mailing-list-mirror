From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like
 write failures
Date: Wed, 06 Feb 2008 10:48:57 -0600
Message-ID: <47A9E4F9.8050100@nrlssc.navy.mil>
References: <Pine.GSO.4.63.0802051844220.15867@suma3> <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Steven Tweed <d.s.tweed@reading.ac.uk>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMnTc-0006PQ-DT
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 17:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbYBFQtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 11:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbYBFQtl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 11:49:41 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60196 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbYBFQtk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 11:49:40 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m16Gmwhh010676;
	Wed, 6 Feb 2008 10:49:00 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Feb 2008 10:48:57 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
X-OriginalArrivalTime: 06 Feb 2008 16:48:57.0503 (UTC) FILETIME=[2A7FA2F0:01C868E0]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--5.019900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDYzOS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwNDc0Ny03MDIxMTgtMTIxNjY1LTcwODU1OC03?=
	=?us-ascii?B?MDQ5MjctMTA2NDIwLTcwMTQ1NS03MDM1MjktNzA1MTAyLTcwNDI1?=
	=?us-ascii?B?Ny03MDgxNzktNzAyMzc2LTcwOTU4NC03MDIzNTgtMTM5NjI5LTEw?=
	=?us-ascii?B?NTI1MC03MDA2OTMtNzAwNDc2LTE0ODAzOS0xNDgwNTEtMjAwNDI=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72818>

Nicolas Pitre wrote:
> On Tue, 5 Feb 2008, David Steven Tweed wrote:
> 
>> @@ -115,5 +139,6 @@ int cmd_prune(int argc, const char **argv, const char
>> *prefix)
>>
>>  	sync();
>>  	prune_packed_objects(show_only);
>> +	remove_temporary_files();
> 
> Maybe you could implement the "show_only" mode for 
> remove_temporary_files() as well?  Otherwise the -n option would not be 
> respected.

I also suggest taking a look at the functions in builtin-prune-packed.c to see
how similar functions are implemented there.

Use strlcpy instead of sprintf.
Use prefixcmp instead of strncmp.
Use same messages as prune_dir() for show_only path and unlink failure.
You could also check the opendir call and print a suitable message on failure.

-brandon

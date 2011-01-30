From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sun, 30 Jan 2011 12:41:14 -0500
Message-ID: <4D45A2BA.8040908@gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org> <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com> <alpine.LFD.2.00.1101281304270.8580@xanadu.home> <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com> <alpine.LFD.2.00.1101281502170.8580@xanadu.home> <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com> <7voc6yc2au.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1101301208270.8580@xanadu.home>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Jan 30 18:41:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjbHG-0002pb-Ky
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 18:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab1A3RlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 12:41:25 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50482 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab1A3RlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 12:41:24 -0500
Received: by vws16 with SMTP id 16so1741575vws.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:disposition-notification-to:date
         :from:reply-to:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Q4geEDUTa6jZjh49Ohl//cGMm+Vj/gqrYs9czprTSNQ=;
        b=DCEfkIruCVxrYwPNf/u+b9VZeGI7vgJw3SxXTBED2yQj9XXlKJAur0l0Bf+JqtcjPM
         W5s9TWx6hzQ16xdVL4BLRSwosd8CZqtRLf2VNUjKjTPjIkF9E0aS0gWbCn+DOGRnfSwm
         rcnUu1JfRy9RHPhaS35rjjLh8HrI5mQ9BDBRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=V1lvc8tsNa/moZaRQnjARIUbyDfZBp7McGEhv972LUfLsEXvR7zqZpNn0HvtiSnsAA
         c8LWM1tVmt3KN3xV1kZJVtD3ooGhPaIhu17b/2zvs5uFDtHetbyvrSSbRrLjQO+6vhTL
         3UuiZOjEOfJ8zfGNR6vNgSsWYH72Dr6HfioX0=
Received: by 10.220.200.77 with SMTP id ev13mr1317785vcb.236.1296409283246;
        Sun, 30 Jan 2011 09:41:23 -0800 (PST)
Received: from [10.0.1.130] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id j15sm6484853vcs.20.2011.01.30.09.41.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 09:41:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
In-Reply-To: <alpine.LFD.2.00.1101301208270.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165691>

On 01/30/2011 12:14 PM, Nicolas Pitre wrote:
> On Sat, 29 Jan 2011, Junio C Hamano wrote:
>
>> Shawn Pearce<spearce@spearce.org>  writes:
>>
>>> I fully implemented the reuse of a cached pack behind a thin pack idea
>>> I was trying to describe in this thread.  It saved 1m7s off the JGit
>>> running time, but increased the data transfer by 25 MiB.  I didn't
>>> expect this much of an increase, I honestly expected the thin pack
>>> portion to be well, thinner.  The issue is the thin pack cannot delta
>>> against all of the history, its only delta compressing against the tip
>>> of the cached pack.  So long-lived side branches that forked off an
>>> older part of the history aren't delta compressing well, or at all,
>>> and that is significantly bloating the thin pack.  (Its also why that
>>> "newer" pack is 57M, but should be 14M if correctly combined with the
>>> cached pack.)  If I were to consider all of the objects in the cached
>>> pack as potential delta base candidates for the thin pack, the entire
>>> benefit of the cached pack disappears.
>>
>> What if you instead use the cached pack this way?
>>
>>   0. You perform the proposed pre-traversal until you hit the tip of cached
>>      pack(s), and realize that you will end up sending everything.
>>
>>   1. Instead of sending the new part of the history first and then sending
>>      the cached pack(s), you send the contents of cached pack(s), but also
>>      note what objects you sent;
>>
>>   2. Then you send the new part of the history, taking full advantage of
>>      what you have already sent, perhaps doing only half of the reuse-delta
>>      logic (i.e. you reuse what you can reuse, but you do _not_ punt on an
>>      object that is not a delta in an existing pack).
>
> The problem is to determine the best base object to delta against.  If
> you end up listing all the already sent objects and perform delta
> attempts against them for the remaining non delta objects to find the
> best match then you might end up taking more CPU time than the current
> enumeration phase.

Why worry about best here? Just add the object (or one of the objects) 
with the same path from the commit you found in step 0, above, to the 
delta base search for each object to pack.

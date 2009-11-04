From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Wed, 4 Nov 2009 22:41:42 +0100
Message-ID: <40aa078e0911041341s1adbbf31t6961207ba9c7905b@mail.gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
	 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:42:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ncL-0004Mj-8z
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456AbZKDVlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 16:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758244AbZKDVlj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:41:39 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57885 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468AbZKDVli convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 16:41:38 -0500
Received: by bwz27 with SMTP id 27so9380320bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 13:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nWRkTjgjGjh/3rcGrriEFub0lNEAzaRyyt5yk3aQftk=;
        b=rsJElD5LiBUdv2fsEIayZwroxCe2cXadbd2QHQWvsm2TmmkOkERcLoWC6m4vHzOHWF
         cPi9AdgFL3sPsuN6oPe+dawCNPYICc6bxirpYYGlGxMa560w7GWhY2sWWT6qG31i/YNc
         JTSKKGg+/MuApJaNjGhc7ce9uYYFCP/B27RxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Hnq4PA7VkXcmmqZPK9qyzaG7kSc9JXQcpwNBhMdopyKj51cRDdTYTEnr9zxmYX1xIh
         be1B6N5fjcPfnezaKvJM454C/M2toAYFIU68rGdaVzWE3as5bH3m3ILLswjh6UFGe9w9
         nCoaH66MDXtyAGPWnK0bVDAAJeuZfOBkLNEk8=
Received: by 10.204.36.202 with SMTP id u10mr2031882bkd.196.1257370902527; 
	Wed, 04 Nov 2009 13:41:42 -0800 (PST)
In-Reply-To: <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132155>

On Wed, Nov 4, 2009 at 10:16 PM, Andrzej K. Haczewski
<ahaczewski@gmail.com> wrote:
>>> +static THREAD_RET_TYPE threaded_find_deltas(void *arg)
>>
>> Why can't you just cast the function pointer in your pthread_create
>> wrapper instead? =A0No one cares about the returned value anyway.
>
> Because of calling convention - I'd have to cast cdecl function as
> stdcall function, which would change the function call clean up (in
> cdecl caller is responsible for unwinding stack, stdcall callee; the
> effect - double stack unwinding).
>

Couldn't the windows version of pthread_create have a wrapper
function, that corrected the calling convention, much like the
function run_thread that start_async in run-command.c has?

--=20
Erik "kusma" Faye-Lund

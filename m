From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 00:52:53 -0500
Message-ID: <478855B5.9070600@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 06:53:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDZJR-0003BD-M2
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 06:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbYALFw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 00:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757702AbYALFw7
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 00:52:59 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:65517 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758082AbYALFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 00:52:57 -0500
Received: by an-out-0708.google.com with SMTP id d31so299097and.103
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 21:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=TIScCQuyEeGIOc+qPTvltc6Maw1FgyXx5EUtMmRDyT0=;
        b=kt5nabXUsfDNnxMSRCvmkDI74QuaJa3oQzso/aMm79UIMoKd0GtTPCstMHwvjsyWUCugbu+L1Z5+ou97QOtnCPpIV4lTzYI+hqRvy0At9Yn8P8ofRww3lzNVaeqo5kag7jYBUsa5QFJXkcFCBApedDrT/FoTk3mMQyBOx2TpVsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qjO4WICd08mwdHTVsiShQZV2P7QuvjeJfLFNlYHMevX44t0VZMH+LruetQ9RC6Rnuf6j3+4ehN2eSDNHy90J9W2sscSdmq5p8Jb++NQ5BX5k0BUurtY/l7XIjtp9vxEx/pc38a6w0mTQlh6HL2VOCGWIQHZ6y9LnYiyJnjFxThk=
Received: by 10.101.68.19 with SMTP id v19mr8631513ank.13.1200117176929;
        Fri, 11 Jan 2008 21:52:56 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id c28sm6066274anc.32.2008.01.11.21.52.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jan 2008 21:52:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70268>

Junio C Hamano wrote:
> "Mark Levedahl" <mlevedahl@gmail.com> writes:
>   
> Thanks.
>
> I have to admit that I happen to agree with Dscho.  I do not see
> this helping to solve communication issues very much.
>   
Junio,

My use really is a different use-case than is typical. Origin is a great 
concept for the common case of projects with a single upstream 
repository. Except for cloning, you don't have to know or care the name 
of the upstream as you move from project to project, it is just always 
"origin" and you use the same remote nickname in each.

This breaks down in a project like mine where there are multiple servers 
and the differences are important. Content and usage vary server to 
server, not just connectivity. At this point, hiding the server names is 
counterproductive. Basically, use of origin is data hiding, and data 
hiding is not good when you actually need the data.

Across the git project, I believe everyone basically understands origin 
as git.kernel.org/..., and origin is not ambiguous. There is just one 
server. For my project, there are multiple servers and a number of us 
pull from and push to multiple servers with no intent that any one 
server has everything (This multiplicity is necessary for several 
reasons, and we have various guards in place restrict the content of 
different servers). Thus, there really is no usefully defined *origin*. 
There just isn't. This is where the disagreements lie.

The argument against my approach of explicitly naming the server rests 
upon the premise that hiding a half-dozen servers, all different and 
with those differences being important, under the single universal name 
"origin", makes things easier. It doesn't when different servers are 
different. Yes, it is possible to figure out what "origin" means at a 
given client, and thus understand how to address a given server from 
that client. That is the essence of the problem. It is clear to address 
server1 as "server1", and server3 as "server3." It is not helpful to 
sometimes refer to server1 as origin, sometimes as server3, and thus 
need to know the definition of origin to know how to name the server. 
For the "normal" git use-case the specific definition of origin is 
unimportant when you use it and so provides a useful abstraction. That I 
must know what origin means in order to know what to do indicates the 
abstraction is counter-productive.

Until we started using sub-modules, we used git clone --origin 
<nickname> and per our standard usage never even had "origin" defined. 
We just agreed on a common set of nicknames for our servers and used 
those. Not everyone had all the remotes defined, but nickname "foo" 
meant the same thing everywhere it was defined. That worked very well 
for us.

So, all I am doing here is trying to extend a basic multi-server 
capability git already has for a monolithic project into projects using 
sub-modules. This will let us resume working the way we did before and 
stop overloading a single nickname (origin) with multiple meanings.

Mark

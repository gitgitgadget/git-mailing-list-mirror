From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 3/4 (resent)] gitweb: Optionally add "git" links in project list page
Date: Tue, 12 Jan 2010 14:05:22 +0100
Message-ID: <201001121405.24365.jnareb@gmail.com>
References: <1262534850-24572-1-git-send-email-jnareb@gmail.com> <201001091220.20446.jnareb@gmail.com> <4B4BC4CB.2030409@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 14:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUgRG-0002Ug-VQ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 14:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099Ab0ALNFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 08:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943Ab0ALNFe
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 08:05:34 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:37033 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab0ALNFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 08:05:34 -0500
Received: by bwz27 with SMTP id 27so1038899bwz.21
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 05:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Tah5c+jht5yq756MENq1qDREVm2ime2wKFSxqf9VzDM=;
        b=TeFT3cc+veoAImSkZWO6Ne9+if2TW4uPRQqxAq9KP+3w+TCpV/o9gAB+UKGZuYgRjh
         vznk8G1WoFzWAZklPidiwKrafTopTjlcoa8kcHYoVzs1mRnYfJj6h0WmRdXVMIqbql3V
         j1d/h2f8q/M6XmgBpzB6v+46emgWvgFM3XW6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q80+55Y3mNJ0zd+XauGZ3vKs0xLCD+G7b4XHKT+ij7NTT4rSzuitq/wMqT1va5T+eW
         rvaVdeWwHtXQvD0x2hw+lxDv85ZTvJMYqaqpNn/8mlkaDxXlwxlAMmnLTXkUTjSfTZVk
         BsnwI8b/AKlMSd5PzIuJ1rDDEemaA8EGYsWfw=
Received: by 10.204.3.220 with SMTP id 28mr5164239bko.4.1263301531965;
        Tue, 12 Jan 2010 05:05:31 -0800 (PST)
Received: from ?192.168.1.13? (abvo182.neoplus.adsl.tpnet.pl [83.8.212.182])
        by mx.google.com with ESMTPS id 15sm9354440bwz.12.2010.01.12.05.05.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Jan 2010 05:05:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B4BC4CB.2030409@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136718>

On Tue, 12 Jan 2010, J.H. wrote:
> On 01/09/2010 03:20 AM, Jakub Narebski wrote:
>> On Sat, 9 Jan 2010, J.H. wrote:

>>> I have given some initial thought to converting the $output options I'm
>>> currently using to a print <FH> that Jakub is suggesting & exploring.
>> 
>> It's 'print {$fh}', i.e. use indirect filehandle, not global filehandle.
>> 
>>> I think all told it's going to be a similarly sized patch, since all
>>> output still has to get adjusted (including the things that directly
>>> output but don't print).  
>> 
>> print -> print {$fh} can be separate patch, and it can be checked that
>> it produces the same results.  Well print -> $output .= could also be
>> separate patch...
>> 
>>> I'm unsure if there's a real advantage to 
>>> either way, other than design preference. My patch (forcing the output
>>> to get passed around) moves towards more of a modal style design
>>> separating data & layout vs. it's combined nature now, well it's a step
>>> in that direction anyway.
>> 
>> Errr... what?  Forcing buffering (you need to read whole output into
>> memory, including for snapshots (uncompressed in case of .tar.gz))
>> is IMVHO orthogonal to the issue of separating data & layout.
>> BTW. Modern web server interfaces like Rack, PSGI/Plack etc. explicitly
>> include streaming support.
> 
> The inbuilt streaming support does change things, and I don't think it
> ultimately changes my caching engine really anyway - I should have that
> change done shortly.

It doesn't change caching engine much, especially if you encapsulate this
detail in the caching engine.  With 'print {$fh}' (and in a few places
'printf {$fh}' (!)) you can just do something like:

  $fh = $cache_fh;
  $actions{$action}->();
  show_cached($fh);


About 'should have that change done shortly': I am working now, time 
permitting, on splitting your caching patch in smaller parts, wrapping
it a bit differently (and hopefully more clear).

>> The advantage of doing 'print {$fh}' is that $fh can be \*STDOUT, can
>> be \$buffer, but can be filehandle to (temporary) file on disk, and
>> you can even "tee" it, i.e. both write to memory/file, and to STDOUT.
>> The number of possible choices / possible improvements is much larger.
>> 
>> And what is also important it means that people who do not use caching
>> do not suffer latency penalty and memory pressure from caching 
>> infrastructure they do not use.

-- 
Jakub Narebski
Poland

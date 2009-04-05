From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH] Add custom memory allocator to MinGW and MacOS
 builds
Date: Sun, 05 Apr 2009 20:43:49 +0200
Message-ID: <49D8FBE5.9060602@gmail.com>
References: <1238766761-3576-1-git-send-email-marius@trolltech.com> <a5b261830904031412o60b7eb4fv7e25a2ca4f89fe60@mail.gmail.com> <49D6ED32.4000706@gmail.com> <200904040835.24377.j6t@kdbg.org>
Reply-To: mstormo@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mstormo@gmail.com, msysgit@googlegroups.com,  patthoyts@googlemail.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Apr 05 20:45:28 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqXLT-00030H-9Q
	for gcvm-msysgit@m.gmane.org; Sun, 05 Apr 2009 20:45:27 +0200
Received: by yx-out-2122.google.com with SMTP id 22so648695yxm.63
        for <gcvm-msysgit@m.gmane.org>; Sun, 05 Apr 2009 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=shqwfUEwrA4IH7y/YNdxOdkfovgxdnvSJUEwxQbdUhM=;
        b=RiY7gfG1PEVqz2M4hDC8zvDQlECgHfloWoe+iVko5RapLHzxH/0GZLuZPu+5qksoe1
         bMUXdSXm+Sx6877Ny4bTOYCzZyCG3Am6uGNQvLSBuBF9hQv9OhXsNB0fhdYiXLYly0Sj
         4oztYLp+uthVLW/jiP73JJbFP7p39am+8H74o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=cgz8MZ9TeTDhboJRdTxBidtIK8ozHwwK8VoedWzu4jkfxd6yd5uxbA1sCNpap6hF4Z
         fUCNFIfWzLARWUEqdZTduIUPuG65xUuoOvcjpVHsglC5qcr6BVj4p54L2LbeEuYw35eD
         wrie94bw/QhUhikqXXUQyFdf1EvRC97q0Lb3s=
Received: by 10.90.90.6 with SMTP id n6mr546194agb.29.1238957031270;
        Sun, 05 Apr 2009 11:43:51 -0700 (PDT)
Received: by 10.177.145.19 with SMTP id x19gr4657yqn.0;
	Sun, 05 Apr 2009 11:43:51 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.65.2 with SMTP id n2mr111094eba.8.1238957030436; Sun, 05 Apr 2009 11:43:50 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27]) by gmr-mx.google.com with ESMTP id 15si586193ewy.4.2009.04.05.11.43.49; Sun, 05 Apr 2009 11:43:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.27 as permitted sender) client-ip=74.125.78.27;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.27 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-2122.google.com with SMTP id 22so482045eye.55 for <msysgit@googlegroups.com>; Sun, 05 Apr 2009 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from :user-agent:mime-version:to:cc:subject:references:in-reply-to :content-type:content-transfer-encoding; bh=Vr/V6wqCrv7cO+BHLy8HYzOJ1Zv/V54OCdSq+ff2lCs=; b=B4EAmy2J8csjmuCRLIbGVNZExEaIAqDmwFaGkEQOjJGo/EaHx3BuGClfPXSReBkkaU HNgaX1SSmCxWeTx7XPhq0tM41NABdgKlgU+MpdX949iSscZRqGs27t6e7HMMhz7ARJOI 3OdZzuf58sO3pMFzyikOf8hWdKsQ8C38P3Z+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:user-agent:mime-version:to:cc:subject :references:in-reply-to:content-type:content-transfer-encoding; b=PH0O9LamWVuAzBWUFaGoj/X3Axcb1H+kKJeMDqOqCjpeU6UiBhD226h1ulKhSEWoKF iYAXk9hsHV78bcMo8Wc3JvgnhNwZKF19bbEqe04Fw987bkb2YT46gv3fdj2sMvuj8YDV rIAcg3yN4XNJhX23SX/iYZUsD+20ha6qS5ro0=
Received: by 10.210.56.7 with SMTP id e7mr428955eba.98.1238957029358; Sun, 05 Apr 2009 11:43:49 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206]) by mx.google.com with ESMTPS id 5sm5542225eyf.32.2009.04.05.11.43.47 (version=TLSv1/SSLv3 cipher=RC4-MD5); Sun, 05 Apr 2009 11:43:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <200904040835.24377.j6t@kdbg.org>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115676>


Johannes Sixt said the following on 04.04.2009 08:35:
> On Samstag, 4. April 2009, Marius Storm-Olsen wrote:
>> Pat Thoyts said the following on 03.04.2009 23:12:
>>> The difference on Windows Vista is that the low fragmentation
>>> heap is the default memory allocator. On Windows XP you need to
>>> enable it specifically for an application. So a possible
>>> alternative to this is just to enable the low fragmentation
>>> heap. (done via GetProcessHeaps and HeapSetInformation Win32
>>> API calls).
>> I know about the low-fragmentation heap, but given that it was
>> only supported on XP and up (and given that I also had MacOSX in
>> mind when considering a custom allocator; see MacOSX got 12%
>> itself ;-), I didn't even consider it. Thanks for clearing up the
>> differences on the Vista and XP benchmarks though! Makes sense.
> 
> Wouldn't a GetProcessHeaps/HeapSetInformation solution add much
> less code, even with a runtime check whether the feature is
> supported?

It certainly would, if you'd also like to simply ignore the extra 
benefit to MacOSX, which was a not-so-bad additional 12%. However, I 
and several of my colleagues also use Git on Mac and see that any 
improvement in the performance there would also be welcome. So, I went 
with the custom allocator approach, instead of just looking into XP.

There might also be other platforms which could benefit from such a 
custom allocator, so I figured that there were many positive sides to 
this, rather than just going for the Low Fragmentation Heap on Windows.


> The improvement that you observed is in a rather special area 
> (repack). How is the improvment in day-to-day tools:
> 
> - procelains used on command line: git-status, git-add, git-commit,
>  git-diff, git-log, perhaps even local git-fetch.
> 
> - plumbing used by guis: git-diff-files, git-diff-tree, git-log, 
> git-rev-parse
> 
> - I'm not even mentioning git-am, git-rebase, because here the time
>  sink is the fork emulation.
> 
> I doubt that the improvement is equally great, and it will perhaps 
> vanish in the noise. 7000+ LOC is a bit much in this case, don't 
> you think so?

I went with repack because it's a lot of data munging, and not so high 
IO. Clearly more I/O intensive git operations would not benefit as 
much as repack. But the goal in this patch was not to speed up I/O.

Obviously there are things that can be, and should be done for the I/O 
side too, but that's a separate subject.

I don't see the 7000+ LOC as such a big deal, given that they are all 
neatly tucked away in a compat subdirectory. They don't even add any 
additional sourcecode to the codepaths, since you just link with it.

Given the benefits, even 5% better than the Low-Frag case for 
single-threaded cases (which is the most dominant in git anyways), it 
think it's reason enough to include it. The 12% boost on Mac should 
also underline this.

Running 'git blame' on one of the files in my repos gives me this result:
XP
     Without nedmalloc: 11.218sec
     With nedmalloc   :  9.514sec (18% speedup)
OSX
     Without nedmalloc: 15.046sec
     With nedmalloc   : 13.957sec (8% speedup)

I'll take those speedups any day :-)


> BTW, I assume that the Boost license is compatible with GPL. But 
> did you check that?

Of course I did, you'll find it under
http://www.fsf.org/licensing/licenses/index_html#GPLCompatibleLicenses

--
.marius

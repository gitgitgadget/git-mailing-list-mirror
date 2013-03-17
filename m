From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Sun, 17 Mar 2013 15:27:21 -0700
Message-ID: <7vli9lpsqe.fsf@alter.siamese.dyndns.org>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
 <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
 <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
 <7vk3p9wqh5.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr>
 <7v4ngcwt4w.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1303151719170.32216@tvnag.unkk.fr>
 <20130316120300.GA2626@sigill.intra.peff.net>
 <alpine.DEB.2.00.1303162355120.21738@tvnag.unkk.fr>
 <CALWbr2wQNM=7vUcoragNmKGpSeXkOCsmsM5y1AMhj95i15A4bw@mail.gmail.com>
 <alpine.DEB.2.00.1303172305230.21738@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Antoine Pelisse <apelisse@gmail.com>,  Jeff King <peff@peff.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,  kusmabite@gmail.com,  git
 <git@vger.kernel.org>,  msysgit@googlegroups.com
To: Daniel Stenberg <daniel@haxx.se>
X-From: msysgit+bncBCG77UMM3EJRBS4GTGFAKGQEPE2CZHY@googlegroups.com Sun Mar 17 23:27:50 2013
Return-path: <msysgit+bncBCG77UMM3EJRBS4GTGFAKGQEPE2CZHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gg0-f189.google.com ([209.85.161.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBS4GTGFAKGQEPE2CZHY@googlegroups.com>)
	id 1UHM3Q-0000dE-2N
	for gcvm-msysgit@m.gmane.org; Sun, 17 Mar 2013 23:27:48 +0100
Received: by mail-gg0-f189.google.com with SMTP id s6sf2166809ggc.16
        for <gcvm-msysgit@m.gmane.org>; Sun, 17 Mar 2013 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:from:to:cc:subject
         :references:date:in-reply-to:message-id:user-agent:mime-version
         :x-pobox-relay-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=zehDob99HUSaVbr6ANl37CG1oT/BclpIGdV2dTjpeNg=;
        b=h9OIfKBKW1oOcUZUhF8SBqn2JOmHs8u0MLdFywij0nxKrdnPv5Qv2srdKO8wRvpJZe
         NXe3lwVos/SD5Jom9m0r5k035jSXPdBolE3tRRHQAWIK5GtwIZySzprpEhtjo5viOQ82
         gTruOhpbJXR8Pu1BCfsXTmE+BoOa5GWI13KeUHDvhkVb/9cwbv/Zi55o+iw4s2OqYMv7
         8Pus3driE/Vg4zSh1nm8t+p0XjH8AAwHV7jZCFY9xMnQnoEGCk643Q0vYBAWWvEZUd7F
         j3mIlWfxB+3yGHyGzj25Vdzzi65ypwevAcY 
X-Received: by 10.49.97.166 with SMTP id eb6mr1108843qeb.0.1363559244689;
        Sun, 17 Mar 2013 15:27:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.96.100 with SMTP id dr4ls1121045qeb.93.gmail; Sun, 17 Mar
 2013 15:27:23 -0700 (PDT)
X-Received: by 10.58.4.137 with SMTP id k9mr11603054vek.1.1363559243727;
        Sun, 17 Mar 2013 15:27:23 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id bl2si1917595vdb.3.2013.03.17.15.27.23;
        Sun, 17 Mar 2013 15:27:23 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF0FBE8A;
	Sun, 17 Mar 2013 18:27:23 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53293BE88;
	Sun, 17 Mar 2013 18:27:23 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5156BE86; Sun, 17 Mar 2013
 18:27:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1303172305230.21738@tvnag.unkk.fr> (Daniel
 Stenberg's message of "Sun, 17 Mar 2013 23:11:28 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D681439A-8F51-11E2-9D39-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218380>

Daniel Stenberg <daniel@haxx.se> writes:

> On Sun, 17 Mar 2013, Antoine Pelisse wrote:
>
>>> With redirects taken into account, I can't think of any really good way
>>> around avoiding this init...
>>
>> Is there any way for curl to initialize SSL on-demand ?
>
> Yes, but not without drawbacks.
>
> If you don't call curl_global_init() at all, libcurl will notice that
> on first use and then libcurl will call global_init by itself with a
> default bitmask.
>
> That automatic call of course will prevent the application from being
> able to set its own bitmask choice, and also the global_init function
> is not (necessarily) thread safe while all other libcurl functions are
> so the internal call to global_init from an otherwise thread-safe
> function is unfortunate.

So in short, unless you are writing a custom application to talk to
servers that you know will never redirect you to HTTPS, passing
custom masks such as ALL&~SSL to global-init is not going to be a
valid optimization.

I think that is a reasonable API; your custom application may want
to go around your intranet servers all of which serve their status
over plain HTTP, and it is a valid optimization to initialize the
library with ALL&~SSL.  It is just that such an optimization does
not apply to us---we let our users go to random hosts we have no
control over, and they may redirect us in ways we cannot anticipate.

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Mon, 18 Mar 2013 11:38:48 +0100
Message-ID: <CABPQNSasFV-vZSMygu16xc-C2d3jTt7mtzFsYQyNUhS5jL-EoQ@mail.gmail.com>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
 <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
 <7vmwu6x72q.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
 <7vk3p9wqh5.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr>
 <7v4ngcwt4w.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1303151719170.32216@tvnag.unkk.fr>
 <20130316120300.GA2626@sigill.intra.peff.net> <alpine.DEB.2.00.1303162355120.21738@tvnag.unkk.fr>
 <CALWbr2wQNM=7vUcoragNmKGpSeXkOCsmsM5y1AMhj95i15A4bw@mail.gmail.com>
 <alpine.DEB.2.00.1303172305230.21738@tvnag.unkk.fr> <7vli9lpsqe.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Stenberg <daniel@haxx.se>, Antoine Pelisse <apelisse@gmail.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, git <git@vger.kernel.org>, 
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRBYO5TOFAKGQE57WHRGA@googlegroups.com Mon Mar 18 11:39:56 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBYO5TOFAKGQE57WHRGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f64.google.com ([209.85.219.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBYO5TOFAKGQE57WHRGA@googlegroups.com>)
	id 1UHXTt-0006nZ-RJ
	for gcvm-msysgit@m.gmane.org; Mon, 18 Mar 2013 11:39:54 +0100
Received: by mail-oa0-f64.google.com with SMTP id l20sf2363755oag.19
        for <gcvm-msysgit@m.gmane.org>; Mon, 18 Mar 2013 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=BFf0Dst2lhFTJOTjDvTXEZrPp1qf4/fqkUVewKEQ6uU=;
        b=UkpjHhjSYuWIpPCNaPuHI8fuYFx9UDR9UcbvLHtukUZsf4hdTewfv77x2QkaqBKGx3
         NupFBXJBOcV7E0bT+nbMmNmrpAYmziIC93F30yYulcWFa+a8l95Holrvg0b3LDyYHE/G
         dMSQhVq+/lsbspF9TiMr4dOlpusAsJkHv4JWcpC3nwGyw7+S5fQ579sOOVpHMrPcJxFt
         JAh7JHkaLiT+naBq8wbKu2eg3SXzlYE0NSGbu0QQs66p6bq3YdnxaNJfe5YFY0D4hR12
         RfvH4GwHOWM8m3+1oQdXgigAr5w0vcT8cnGhT4CyY8t 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=BFf0Dst2lhFTJOTjDvTXEZrPp1qf4/fqkUVewKEQ6uU=;
        b=NbdPIO7ZA/uj+tzYrex5L99GIiqi+ABZ2HMYEYOkVSoK4DwgXOsATcmmaVWHEqAcIP
         g4c7N7oFNAWOicOT55WMLs9c6F2omyugYdJeCccuLnBkRxe6qk1dezVJKaCCdUNd3zeq
         yu5QYBJmICVduRPchT42qduMbWCQhzU0ek529I7BKiJOuVtkCQyhVTkY8kEHX/smyYCZ
         rNs3LR6nmZGrt1+rogEx98z3coAPJF7rxBiWh4KgHoTSP8j0OnWN8+bNLDrJYXo1Tv1x
         MtrVDJvvs0MQt2tTce+4mzxpjnRiCApp6ShxK9N3J8C6zbJgif 
X-Received: by 10.50.140.65 with SMTP id re1mr1099798igb.13.1363603170063;
        Mon, 18 Mar 2013 03:39:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.88.129 with SMTP id bg1ls965897igb.13.gmail; Mon, 18 Mar
 2013 03:39:29 -0700 (PDT)
X-Received: by 10.50.183.164 with SMTP id en4mr6932506igc.2.1363603169213;
        Mon, 18 Mar 2013 03:39:29 -0700 (PDT)
Received: from mail-ie0-x231.google.com (mail-ie0-x231.google.com [2607:f8b0:4001:c03::231])
        by gmr-mx.google.com with ESMTPS id j7si344124igc.3.2013.03.18.03.39.29
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 03:39:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::231 as permitted sender) client-ip=2607:f8b0:4001:c03::231;
Received: by mail-ie0-x231.google.com with SMTP id 16so6515874iea.8
        for <msysgit@googlegroups.com>; Mon, 18 Mar 2013 03:39:29 -0700 (PDT)
X-Received: by 10.50.7.211 with SMTP id l19mr2508511iga.53.1363603169118; Mon,
 18 Mar 2013 03:39:29 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Mon, 18 Mar 2013 03:38:48 -0700 (PDT)
In-Reply-To: <7vli9lpsqe.fsf@alter.siamese.dyndns.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::231
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218402>

On Sun, Mar 17, 2013 at 11:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Daniel Stenberg <daniel@haxx.se> writes:
>
>> On Sun, 17 Mar 2013, Antoine Pelisse wrote:
>>
>>>> With redirects taken into account, I can't think of any really good way
>>>> around avoiding this init...
>>>
>>> Is there any way for curl to initialize SSL on-demand ?
>>
>> Yes, but not without drawbacks.
>>
>> If you don't call curl_global_init() at all, libcurl will notice that
>> on first use and then libcurl will call global_init by itself with a
>> default bitmask.
>>
>> That automatic call of course will prevent the application from being
>> able to set its own bitmask choice, and also the global_init function
>> is not (necessarily) thread safe while all other libcurl functions are
>> so the internal call to global_init from an otherwise thread-safe
>> function is unfortunate.
>
> So in short, unless you are writing a custom application to talk to
> servers that you know will never redirect you to HTTPS, passing
> custom masks such as ALL&~SSL to global-init is not going to be a
> valid optimization.
>
> I think that is a reasonable API; your custom application may want
> to go around your intranet servers all of which serve their status
> over plain HTTP, and it is a valid optimization to initialize the
> library with ALL&~SSL.  It is just that such an optimization does
> not apply to us---we let our users go to random hosts we have no
> control over, and they may redirect us in ways we cannot anticipate.
>

I wonder. Our libcurl is build with "-winssl" (USE_WINDOWS_SSPI=1), it
seems. Perhaps switching to openssl (which we already have libraries
for) would make the init-time better?

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

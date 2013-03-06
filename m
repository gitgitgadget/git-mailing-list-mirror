From: Yves Blusseau <yves.blusseau@gmail.com>
Subject: Re: Using socks proxy with git for http(s) transport
Date: Wed, 6 Mar 2013 11:09:47 +0100
Message-ID: <CABmRxH25y9bAdZWV_3MG7x2LNGNDQbLB_EJC1xAJC396nO7bYQ@mail.gmail.com>
References: <CABmRxH1g2BR+-MvGZ4J-2vC8NDq3x8pG148hXfuYTpUkX0L=0A@mail.gmail.com>
	<20130306082110.GA31638@sigill.intra.peff.net>
	<CABmRxH2CGTxFaGufSMgUqhrSTZPvFBHoEnP8-p5HhkU4kszJPw@mail.gmail.com>
	<20130306094552.GA11531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 11:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDBIc-0006rJ-CF
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 11:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab3CFKJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 05:09:48 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:56788 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123Ab3CFKJs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 05:09:48 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so5755410pbc.9
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 02:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rX7TFfZeq7uhPT2AnDVb7AlDUiSnGtzsmsRcxDpUaSI=;
        b=AS2t09n9e8rESDpKF7DbGVlswyeJU0SyJ8RQgwQYs6jwi2JybNGLREQ5n7A8ex6Rro
         +Tur7qaH0omtljci/WsdMGP6Hl3Pf/KKH02LEL9O4TgDJm2vM/xthmcHxL3cPIb0Dy+G
         WRKxDidRSBpH5DAvhxeHFFtRRzaCfhtYGRzgnT4zE7+KLjLUrKUCgaPPWJCr/Mk2tkH+
         YwENMKKg8RZ2s3urxcxECtE12sAg+Hn5Qclc6SGAnRxgyzr+314TwKE2lH28HpMFYCTV
         glUHz3ITWe6eI13/0u0zs7/YguEhPahUCEKVq3O3TUyzKt5mNSC9VzaD9HZ+iBIH9WEV
         RQrg==
X-Received: by 10.68.220.230 with SMTP id pz6mr44926546pbc.46.1362564587427;
 Wed, 06 Mar 2013 02:09:47 -0800 (PST)
Received: by 10.68.136.225 with HTTP; Wed, 6 Mar 2013 02:09:47 -0800 (PST)
In-Reply-To: <20130306094552.GA11531@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217512>

2013/3/6 Jeff King <peff@peff.net>:
> On Wed, Mar 06, 2013 at 10:21:42AM +0100, Yves Blusseau wrote:
>
>> > Try:
>> >
>> >   git config --global http.proxy 'socks://yourhost:port'
>> >
>> > That will enable it for all git repositories on your machine. Git should
>> > also respect any environment variables that curl handles (because we use
>> > libcurl under the hood), if you prefer to set it up that way. See "man
>> > curl" for details.
>>
>> Thanks Jeff but it's not working.
>
> Hmm. I just double-checked, and it works for me.
>
>> I use git 1.8.15
>
> I assume you mean 1.8.1.5 here.

Yes it's 1.8.15 sorry for the mistake

>
>> My socks proxy listen on my localhost at port 1080 so I do:
>> git config --global http.proxy  'socks://127.0.0.1:1080'
>
> That looks right to me.
>
>> But when i try to talk with a git server with http protocol i have:
>> [...]
>> * About to connect() to proxy 127.0.0.1 port 1080
>> *   Trying 127.0.0.1... * connected
>> * Connected to 127.0.0.1 (127.0.0.1) port 1080
>> > GET http://git.kernel.org/pub/scm/git/git.git/info/refs?service=git-upload-pack HTTP/1.1
>> [...]
>> * Empty reply from server
>
> If I set up a simple socks proxy with ssh, like:
>
>   ssh -v -D 1080 my-ssh-host

My socks proxy is also a socks proxy with ssh

>
> and run the same command, I get:
>
>   * About to connect() to proxy localhost port 1080 (#0)
>   *   Trying 127.0.0.1...
>   * SOCKS4 request granted.
>   * Connected to localhost (127.0.0.1) port 1080 (#0)
>   > GET /pub/scm/git/git.git/info/refs?service=git-upload-pack HTTP/1.1
>   [...]
>   < HTTP/1.1 200 OK

You have a (#0) in the log that i have when using curl directly with
the socks proxy
>
> and it works. It does look like curl is treating localhost:1080 as a
> regular http proxy. What version of libcurl do you have? Is there
> anything in your environment that might be causing it to override the
> configured proxy setting (e.g., an http_proxy or https_proxy environment
> variable)?
I have try with an old version of curl: 7.15.5 and with the latest in
development curl 7.29.1-DEV.
But it seem that git-remote-http is compile with the old one.

I have no http/proxy environment variables

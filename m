From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack.c: chmod +w before rename()
Date: Fri, 24 Jan 2014 15:32:38 -0800
Message-ID: <xmqqwqhpot0p.fsf@gitster.dls.corp.google.com>
References: <201401242205.16313.tboegi@web.de>
	<20140124214023.GB58260@vauxhall.crustytoothpaste.net>
	<alpine.DEB.1.00.1401242318060.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Torsten
 =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  git@vger.kernel.org,
  zwanzig12@googlemail.com,  stefanbeller@googlemail.com,
  kusmabite@gmail.com,  msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRBGPQROLQKGQENMHTGFI@googlegroups.com Sat Jan 25 00:32:47 2014
Return-path: <msysgit+bncBCG77UMM3EJRBGPQROLQKGQENMHTGFI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f190.google.com ([209.85.160.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBGPQROLQKGQENMHTGFI@googlegroups.com>)
	id 1W6qEs-0008NV-VM
	for gcvm-msysgit@m.gmane.org; Sat, 25 Jan 2014 00:32:43 +0100
Received: by mail-yk0-f190.google.com with SMTP id 131sf2033879ykp.7
        for <gcvm-msysgit@m.gmane.org>; Fri, 24 Jan 2014 15:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=rIZR6LQxn+1V4BdH4dGiBTJ83CaxUqVOpRcBGjaWocI=;
        b=qd6wgx4ShrBjoGW7JqRIsxrrCuBseRHjSBw2jJ3Lu5KQRBygi9pd+LmYZWx2qUcLoR
         BuN9aiMLSX1OlJ5J6WhoMksFzBzY14CtSmu+gBaGetVlRH/kjIX5pZPObfrzWHFWbQBa
         m9KodpAsct9vVnB3CCVhqNFa+AnroDWl6vS+/YxmwXQzQJLTiqCAPHBlPm2mxfjg/1n0
         DD6cPyt8yDl2lHo8A8atUJHyt+8G3C+pB3cLQWPy1ufyHq9/UjzsBq+ipRpFCxuu4p9R
         QIT0rxY8+6E22dgAJHpeWN016yYBN+kHx+oVI7ZAgTf14oYQrUV0eTpCw7Dy+RGXiNgN
         2/Wg==
X-Received: by 10.182.33.4 with SMTP id n4mr87791obi.9.1390606361990;
        Fri, 24 Jan 2014 15:32:41 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.22.200 with SMTP id g8ls447649obf.30.gmail; Fri, 24 Jan
 2014 15:32:41 -0800 (PST)
X-Received: by 10.182.108.136 with SMTP id hk8mr6219160obb.11.1390606361132;
        Fri, 24 Jan 2014 15:32:41 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id g1si415555pbw.2.2014.01.24.15.32.40
        for <msysgit@googlegroups.com>;
        Fri, 24 Jan 2014 15:32:41 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6433864812;
	Fri, 24 Jan 2014 18:32:40 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 501EC64811;
	Fri, 24 Jan 2014 18:32:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9433964810;
	Fri, 24 Jan 2014 18:32:39 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1401242318060.14982@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Fri, 24 Jan 2014 23:24:36 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D06ECE24-854F-11E3-98BD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=jch@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241053>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In any case, I'd rather change the permissions only when the rename
> failed. *And* I feel uncomfortable ignoring the return value...

Good judgement I'd agree with 100%.

Thanks.

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

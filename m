From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 5/7] imap-send: provide fall-back
 random-source
Date: Fri, 9 Oct 2009 01:16:50 +0200
Message-ID: <40aa078e0910081616wc1129edr2e1397964a0e6ae5@mail.gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com> <1254530385-2824-2-git-send-email-kusmabite@gmail.com> <1254530385-2824-3-git-send-email-kusmabite@gmail.com> <1254530385-2824-4-git-send-email-kusmabite@gmail.com> <1254530385-2824-5-git-send-email-kusmabite@gmail.com> <20091003095811.GB17873@coredump.intra.peff.net> <40aa078e0910031145l2849697ftd2da2f5aaa28d957@mail.gmail.com> <20091003204317.GB9058@sigill.intra.peff.net> <20091003205217.GC9058@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org, mike@codeweavers.com
To: Jeff King <peff@peff.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Oct 09 01:17:06 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f153.google.com ([209.85.212.153])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw2EL-0003ge-RH
	for gcvm-msysgit@m.gmane.org; Fri, 09 Oct 2009 01:17:06 +0200
Received: by vws17 with SMTP id 17so330680vws.24
        for <gcvm-msysgit@m.gmane.org>; Thu, 08 Oct 2009 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=e+W77JtwXtQbXXwlRTcMXJA8IsOm65RKHvLnTCRTGVw=;
        b=nFCA9DWLRHpNvzKzprpIX+ZIsmSP0j09UYx0cfLMCGWsljvXLIH+bJKVhhff+cq4ne
         nS5yjkjLh3oanAZI6+m3GRox2UPMRC3J6SK5LP7J2RZNlgzZVhPrdmyMlTqmlZD+4bAz
         HpFi5zk27wBBh6uhDLRAIQJY2mAOoktyPYrPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=Cpk63OgkHvD33T7Bjt72mIJNmvdKz7+jPlZaTAt57RQXRiYdxKfbmmtNUEQ7wFCA7E
         O5mr+RA2kt0Y2vwzB24g2qA0jD+Dxp9Dsz4yv7bZ/d3CbyqY7FH3ZmCVnf929soRSeU6
         6S+jKBelZ0tiJ4v70ndKUB0AEjG+Q0nqhWAiQ=
Received: by 10.220.68.134 with SMTP id v6mr298514vci.3.1255043818696;
        Thu, 08 Oct 2009 16:16:58 -0700 (PDT)
Received: by 10.177.117.7 with SMTP id u7gr7349yqm.0;
	Thu, 08 Oct 2009 16:16:55 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.161.203 with SMTP id s11mr44325bkx.17.1255043812384; Thu, 08 Oct 2009 16:16:52 -0700 (PDT)
Received: by 10.204.161.203 with SMTP id s11mr44324bkx.17.1255043812365; Thu, 08 Oct 2009 16:16:52 -0700 (PDT)
Received: from mail-fx0-f227.google.com (mail-fx0-f227.google.com [209.85.220.227]) by gmr-mx.google.com with ESMTP id 14si53525bwz.5.2009.10.08.16.16.51; Thu, 08 Oct 2009 16:16:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.227 as permitted sender) client-ip=209.85.220.227;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.227 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by fxm27 with SMTP id 27so5995535fxm.17 for <msysgit@googlegroups.com>; Thu, 08 Oct 2009 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=/iPPOX6Ndz/SNcjlZyoF4o4/PJVvMHlEGbRfjMUMynw=; b=iFpenDnanM+CjfQDMdY26PpyPmMahHJngInrjjZaEEhsRvG1Bm1xWtBia0jGdwqm1d kaz8TP39W4QFsAqVnEUFfcNj4PS6e7K06q5syDqsqGbU9d96qQuoFCqT3aUFwsHLZ+xc zLWBNH36V1tAHA3hvWj/uonXsX/MUveEvFFfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=CUy+5UbQVZtD4czQRmquXt7jGck/JJb0E1s8uVbLd/qgfgbBgOxg8lSDJ6tuLh30OM eVAAcHe5cyW+DxV8+HZ9/RdLeWG8vWu3SWQOfaYswSKXWddVwzisWHPrbMAJUoU0+nFd WHI324/Z0+DpZ+baiFv7PIUBV8hLU0QFHtURo=
Received: by 10.204.36.206 with SMTP id u14mr1532587bkd.138.1255043810860;  Thu, 08 Oct 2009 16:16:50 -0700 (PDT)
In-Reply-To: <20091003205217.GC9058@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129722>


On Sat, Oct 3, 2009 at 10:52 PM, Jeff King <peff@peff.net> wrote:
>> So that could probably be ripped out, too, with no ill effect.
>
> And here is a patch (on top of the earlier one) to do that.

Alright, so I'm spinning a new version of this series, and I'm
wondering a bit how to include patches like these, where there's no
commit message (because it was a sketch or something, I guess) or
sign-off. Should I send the commit-messages to the author and have the
him/her sign off on them, or should I set me as author and credit the
real author for the actual work in the commit message? I see the
latter have been done quite a bit in git.git already. The benefit of
the first one is of course that authorship is retained, but the
backside is that it incorrectly looks like the author wrote the commit
message.

Are there any preferences?

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656

From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] fast-import.c: Silence build warning
Date: Mon, 31 Aug 2009 21:06:12 -0700
Message-ID: <4A9C9DB4.8070702@gmail.com>
References: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com> 	<7vfxb7y2h3.fsf@alter.siamese.dyndns.org> <d2e97e800908311655t553d6c4bo6ed45fe37819c1d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 06:05:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiKcU-00059N-TO
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 06:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbZIAEFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 00:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbZIAEFK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 00:05:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:27399 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZIAEFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 00:05:09 -0400
Received: by wa-out-1112.google.com with SMTP id j5so627822wah.21
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 21:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=qAygUH9oM0MugthU5FNNHfgMtGj142j+8UyupndqI4M=;
        b=n29JcdmI1DngREmQ9PEbELUSe3C52BPtrpDQ0bV35/f6RPUtw4kHLL5CqP5QrhaoeB
         7rvtJHl8GlIOviuVLylUdAD+WXxLmTVWf+g6i2g9rTJvkPXXFnYBabQ3p98aMNuMh89G
         kbCvRrRIMkA5ljA6w2dVdPGR7R+zjYuRyiUxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=K7KAG9cifzEYqQgRjryRzWD5MCj1Jbwt/3H06S+AtTOGFWAnq+q4DqEQzAC0rpbNa/
         mt7WC84vdVVz+GzFT8dBvpVMOtVZ2Ftbs/q3lFi2vqR74c+LxRvETcydUFoFcy2cbVhR
         8oJ8ZKg/iajm6o0HFx3Xuug9X5gyDRGz+vqss=
Received: by 10.115.3.6 with SMTP id f6mr3783621wai.22.1251777911264;
        Mon, 31 Aug 2009 21:05:11 -0700 (PDT)
Received: from ?10.10.0.5? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id n30sm1590321wag.41.2009.08.31.21.05.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 21:05:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <d2e97e800908311655t553d6c4bo6ed45fe37819c1d8@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127519>

Michael Wookey wrote:
> 2009/9/1 Junio C Hamano <gitster@pobox.com>:
>> Isn't this typically done by casting the expression to (void)?
>
> I originally tried that - the compiler still complains.
>
>> Otherwise a clever compiler has every right to complain "the variable
>> unused is assigned but never used.
>
> I get no other warnings, so does that make gcc less than clever?  ;-) 

I noticed this warning recently too when I upgraded my box and a flurry
of fwrite() unused warnings came up. Looks like ubuntu patches that
issue[1] by arguing it's a valid programming style to
fwrite/fflush/ferror. Perhaps this programming style could follow a
similar reasoning?

It gets better though. Commit c55fae4 (fast-import.c: stricter strtoul
check, silence compiler warning, 2008-12-21) made this change already.
Then commit eb3a9dd (Remove unused function scope local variables,
2009-03-07) came by and removed it. Unless the definition of strtoul
drops the attribute I fear we'll keep going back and forth.

-- Footnotes --
[1] https://lists.ubuntu.com/archives/ubuntu-devel/2009-March/027832.html

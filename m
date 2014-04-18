From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Refactoring hardcoded SHA-1 constants
Date: Fri, 18 Apr 2014 15:40:49 -0700
Message-ID: <20140418224049.GA15516@google.com>
References: <20140418221841.GC57656@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 00:41:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbHSv-0007Yl-8f
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 00:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbaDRWk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 18:40:57 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:53476 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbaDRWk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 18:40:56 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so1866956pbc.27
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Y/FIv2KCQ1rixn6M7g/OEhtGnsEtPcLTdsaa8J6nP6k=;
        b=KSpGfDO06dL+/mHHNExEMfiWMhveK3y6E3nTwNenXeJt4ZpUl+XaXEnJDyFi2gnZQj
         ZsGZ9loZE9g65mWE2BWXEC08+SpkpGMowlcYc/UCtG/OINM3bA3HYXg8J0Vh/cilaogD
         IbSJ7rZ3ud9WWZFw1iWN1oq33wFceTS8L9wcJg0lpQSPJizdW4U2tXK8VRtB8YnWwz0n
         faLw6H+Fmm5wgGNdA2tR6dnuaMosDtfmHIwDrAUGO4B4zdZeRbA13tFyheWTkvvhTzW1
         8GTk40KO1p9+GCRuRYfbSuuGzuq70meWiFmkp8O5iW0ZO9AE8YcQLifgUKYvJOWyrtgf
         kBTw==
X-Received: by 10.68.212.10 with SMTP id ng10mr24490174pbc.95.1397860855789;
        Fri, 18 Apr 2014 15:40:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id y4sm62024523pbk.76.2014.04.18.15.40.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 18 Apr 2014 15:40:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140418221841.GC57656@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246486>

Hi,

brian m. carlson wrote:

> I'd like to introduce a set of preprocessor constants that we'd use
> instead of hard-coded 20s and 40s everywhere.

Lukewarm on that.  It's hard to do consistently and unless they're
named well it can be harder to know what something like
BINARY_OBJECT_NAME_LENGTH means than plain '20' when first reading.

[...]
> I would also like to consider, as a third step, turning all of the
> unsigned char[20] uses into a struct containing unsigned char[20] as its
> only member, like libgit2 does.

That would be very welcome!

It's a nice way to steer people toward hashcmp using the type system,
and it makes it possible to use a union to enforce alignment later if
measurements show benefit.

Thanks,
Jonathan

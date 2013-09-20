From: Martin Gregory <marting@adelaideinterim.com.au>
Subject: re[6]: sparse checkout file with windows line endings doesn't work
Date: Fri, 20 Sep 2013 11:22:01 +0930
Organization: AI
Message-ID: <SDZYTDk4NyMxKC4hPVQvMjM1MDUxNjg3@IBMLT4>
References: <CACsJy8BeT7ZP+ZQah7FR6ogqRNiiDZYP5SEs8J6J=+gEHU5MUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	Martin Gregory <marting@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Fri Sep 20 03:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMpzb-0006Wo-66
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 03:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab3ITB6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 21:58:43 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:33857 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab3ITB6m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 21:58:42 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so9075810pbc.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 18:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :mime-version:organization:content-type:content-transfer-encoding;
        bh=PJeAGWG26tpAfOqiNC9h/e471FS1NGa+56Pm+n/0BDQ=;
        b=RySdWrxhBjZo8s0g6t6+Fs/d7W3a7Jzrz9cSApesaQh8YpQ3NSQ5bnAbBILVXLrYxx
         1JNt5oavMLnM4zY00NOIeXZqFKiA064XKwZTDLs79k5PXvydV7vcKI7ps6bV5Uq8hwkm
         HBulwKQZOYsAap7NQgg/rwL2PB8+LP86pEPKd3a+VQ24WTuKxrXquLy8/KSgNVVUPOka
         D8lsSJosnKW99Sdfryj8D/XnMMs2YKorkfH7pdk65cV0ooEIC4SyQq/WaB1VQMuUz8Go
         RRbt2YUHdsdyaBSufE16JNU9Ul49NO6jVueRYe/cpClRuVc0FCJRE1neekoVxd7+t4wO
         lCPw==
X-Gm-Message-State: ALoCoQnm4/HgbfsRZsl/619UN5z5vZUE0g6HhLjxbhUaE84HLurifnHVr3sl7Fxv0SNGrNZxR8X8
X-Received: by 10.66.25.205 with SMTP id e13mr432713pag.180.1379642322085;
        Thu, 19 Sep 2013 18:58:42 -0700 (PDT)
Received: from IBMLT4 (ppp121-45-31-21.lns20.adl2.internode.on.net. [121.45.31.21])
        by mx.google.com with ESMTPSA id yh1sm12267059pbc.21.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 18:58:41 -0700 (PDT)
In-Reply-To: <CACsJy8BeT7ZP+ZQah7FR6ogqRNiiDZYP5SEs8J6J=+gEHU5MUg@mail.gmail.com>
X-Mailer: GoldMine [9.2.1.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235045>

Thanks Duy for the fast response.

> Anyway there is a trailing space at the
>>  end of the rule. This is the content of your sparse checkout file in C
>>  syntax
>>
>>  "/CONFIGURATION\x20\r\n"
>>
>>  Maybe we could warn about trailing spaces.. Stripping them
>>  automatically is a possibility, but we need an escape hatch for
>>  (crazy?) people who actually have trailing spaces in there paths.

Yuk eh?

I just discovered that if you do

echo /CONFIGURATION      > .git\info\sparse-checkout

in Windows, you get 5 training spaces!

Man, I hate Windows!

Something that would help is an easier way to debug sparse-checkout rules.

When something goes wrong, there appears to be no way to understand what
git thinks it's reading.   I'm not sure if such a way, if it existed, would help with
trailing spaces, but if you could say

git read-tree -muv HEAD

and it would say

reading '.git\info\sparse-checkout'...
rule '/CONFIGURATION ' - no matches

that would solve actually two problems:

1) You can see that it thinks there is a space there

2) the config file name is sparse-checkout, with a dash, not sparsecheckout...
a mistake I made that had me scratching my head for some time, since everywhere
else it doesn't have a dash!

Thanks again for your quick help.

Martin

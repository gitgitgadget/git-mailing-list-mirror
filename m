From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] push: deny policy to prevent pushes to unwanted remotes.
Date: Wed, 15 Jun 2016 21:31:22 +0200
Message-ID: <6974F4AA-F0A7-45DA-99AA-2911C80773AD@gmail.com>
References: <20160530104501.4402-1-antoine.queru@ensimag.grenoble-inp.fr> <C7CBA69F-64BC-4710-8FF7-5CDC2A59E1E5@gmail.com> <1589200049.381440.1465221656049.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	rsbecker@nexbridge.com, aaron@schrab.com, gitster@pobox.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, peff@peff.net
To: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 15 21:31:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDGXB-0004hR-VM
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 21:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbcFOTb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 15:31:26 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35185 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbcFOTbZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 15:31:25 -0400
Received: by mail-wm0-f42.google.com with SMTP id v199so165166617wmv.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 12:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MwEBlf4s+/+L8OtcnuJnhn3g+FSQeFGt5wkQCzjapkk=;
        b=l8fXXMxBqC8nBgK8ZxybG9YKmL6MPRseVJ8Cg/TQdjJNF8kdmCU+sW5iFH2EawtyBS
         xR2HTpp+gjW0z24fog0GNR10UL6ipz1cDLHWMpH26Y8ToS90UNGfremDZ5sEm5xo0fUe
         jc0Zh7g1G6E++KdsSvxJHMUFIIaH3XHbVC3EuKcrLQiQADaacKsLAgmGlDthsIqpUCKq
         i1Jg+/6nhd5mHYbZyyQNyvNKjqXY2+Hg5X26RepAL+d0OsKSvYcZXk24699u14TWeo+o
         DTS2UBBWJea96UI6K/b0cceJZlINLD61HnW2ibMNV85OcGiukAVdYbYRg5Z9PAh5YQgV
         z86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MwEBlf4s+/+L8OtcnuJnhn3g+FSQeFGt5wkQCzjapkk=;
        b=eDKVcClMJK66LMz4dE4vvxPoGxsVnOaCiCBXwZJoOOQ/QbbQTh2yO4InLbaxtIDth5
         zh4zlp/9bbeDw//CnRdhKh0710O0b95N7ST6EF7TMrkZhI3jgqiEwhrM4+rjpb1XEjki
         xOrtppVupTtMGCEz5SENHctgWyDVKMetLz2aeVUhWkq+GSraGyWftl3rE0GKOGx33wIm
         y5Leh4E5LQrcyolyy3pPO8KfKjI3EguKdcBXgP2I9s7Csat+sMWFXosqoxVZMKE2LgQb
         hUK7Y419MDtufJUcXPGdpwSPfuYef8WIH5ElOG9JYg3S/urnafGrnhAomPRP1xjy/T24
         oq3g==
X-Gm-Message-State: ALyK8tLLovj7r/LpTwBkLUgtRTUm7KXDaO+7n3/Y8Ef0o01Iwf9EBp1gnpDaDVlGszUQ5Q==
X-Received: by 10.28.134.199 with SMTP id i190mr11981649wmd.26.1466019083329;
        Wed, 15 Jun 2016 12:31:23 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5125.dip0.t-ipconnect.de. [93.219.81.37])
        by smtp.gmail.com with ESMTPSA id s67sm4858912wmf.3.2016.06.15.12.31.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jun 2016 12:31:22 -0700 (PDT)
In-Reply-To: <1589200049.381440.1465221656049.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297394>


On 06 Jun 2016, at 16:00, Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr> wrote:

> Hello Lars, thanks for your reply. 
>> 
>> 
>>> On 30 May 2016, at 06:45, Antoine Queru
>>> <antoine.queru@ensimag.grenoble-inp.fr> wrote:
>>> 
>>> Currently, a user wanting to prevent accidental pushes to the wrong remote
>>> has to create a pre-push hook.
>>> The feature offers a configuration to allow users to prevent accidental
>>> pushes
>>> to the wrong remote. The user may define a list of whitelisted remotes, a
>>> list
>>> of blacklisted remotes and a default policy ("allow" or "deny"). A push
>>> is denied if the remote is explicitely blacklisted or if it isn't
>>> whitelisted and the default policy is "deny".
>>> 
>>> This feature is intended as a safety net more than a real security, the
>>> user
>>> will always be able to modify the config if he wants to. It is here for him
>>> to
>>> consciously restrict his push possibilities. For example, it may be useful
>>> for an unexperimented user fearing to push to the wrong remote, or for
>>> companies wanting to avoid unintentionnal leaking of private code on public
>>> repositories.
>> 
>> Thanks for working on this feature. Unfortunately I won't be able to test and
>> review it before June 14. I am traveling without laptop and only very
>> sporadic internet access :)
>> 
>> One thing that I noticed already: I think a custom warning/error message for
>> rejected pushes would be important because, as you wrote above, this feature
>> does not provide real security. That means if a push is rejected for someone
>> in an organization then the user needs to understand what is going on. E.g.
>> in my organization I would point the user to the open source contribution
>> guidelines etc.
>> 
>> Thanks,
>> Lars
> 
> I might not understand what you've said, but I think this feature is already 
> implemented in our version, with remote.pushDenyMessage. Is this what you're
> talking about ?

You are right. I was skimming the diff on a very small screen and 
missed that for some reason. Sorry!

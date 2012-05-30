From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Wed, 30 May 2012 01:24:24 -0500
Message-ID: <20120530062424.GA19114@burratino>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <20120528224729.GK14606@burratino>
 <CACsJy8ANyMxLNCP1P28AKywssGdSQP3QnE_HZHHGzkX-4oqFtw@mail.gmail.com>
 <20120529121428.GD14697@burratino>
 <7vmx4q4ycj.fsf@alter.siamese.dyndns.org>
 <CACsJy8BvZSbsXyh3ct-M3rcWQf9Fw4VDX2VYVy+0Hv+53AQWnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 08:24:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZcKk-00051T-N4
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 08:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab2E3GYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 02:24:35 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:55567 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab2E3GYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 02:24:34 -0400
Received: by gglu4 with SMTP id u4so3210910ggl.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=69IhLp3XLPUN60GrjWUYqPb3wDn4nJzit10Dzqrscy8=;
        b=Hc9I+IZ0h+Mi0dyQp0V2g9SVbp9le8Azaux1GbmPYhk6eNBqLrBpUG13boYoQbquy8
         BtIdrIYiB7+EcVWQHYkhX9fyOVz27Cx01hk9aa6ese4dUxR3GbLDn86MLitFExKLCUHW
         JPxbImF9sJ0S+f3OYw47BGYWOqbhgEylZ96T/R35bvnW+FRH3dRINYKT7Az9SlvaO2mQ
         wgfEpVPrBg2UVUJNhIJhBgdX2c6amWL8QQc0GGGGek2d3Nx+6g1wbf1WHbl3k324VoN7
         tVAi3Ttc1JcLVQOlbFplb/DaJzMg/X5BStPvZ5U77pkbHh38VAqXCSUuKHHzivAxOm+4
         LX6Q==
Received: by 10.50.202.35 with SMTP id kf3mr9495384igc.20.1338359072512;
        Tue, 29 May 2012 23:24:32 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ch5sm10441030igb.0.2012.05.29.23.24.31
        (version=SSLv3 cipher=OTHER);
        Tue, 29 May 2012 23:24:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8BvZSbsXyh3ct-M3rcWQf9Fw4VDX2VYVy+0Hv+53AQWnw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198782>

Nguyen Thai Ngoc Duy wrote:

>                             Or generate a poisoned .mo file, then make
> git use that.

Yes, I would like that very much.  I had vague ideas of using some
valid language code that doesn't correspond to a human language, but
an alternate GIT_TEXTDOMAINDIR might be simpler and work better.

> Another thing is GETTEXT_POISON poisons too much. printf(_("this is
> %s\n"), path); is turned to "# GETTEXT POISON #". There's no way for
> test scripts to verify the correct "path" output.

Somes like a good change. ;)

"this is %s\n" could be translated to "poison(%s)" or even "THIS IS
%s\n" to make it easy to recognize which string was poisoned.

When i18n plumbing was starting I thought this would be important and
made a mental note to implement a rot13 function that preserves printf
directives.  In the end I have wanted it much less often than I
thought I would.  In tests that check the effect of commands on a
repository, only checking the output of plumbing commands is just a
good idea anyway.  (But I can understand that preserving printf
directives would be useful for people wanting to test the UI.)

UI tests are tricky.  I can't imagine how a good test for translated
request-pull that doesn't pick a particular language could work, for
example.

Well, hopefully the above is amusing.  Sorry to ramble.

Thanks much again for this series --- the translated help makes it
much easier to imagine git to be a native speaker in a locale where
English is not the main language.

Jonathan

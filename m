From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/12] MINGW: config.mak.uname: add explicit way to
 request MinGW-build
Date: Mon, 28 Apr 2014 09:12:37 -0700
Message-ID: <20140428161237.GA13002@google.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-2-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:12:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeoAr-0003l9-Uh
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbaD1QMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:12:50 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:50271 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968AbaD1QMp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:12:45 -0400
Received: by mail-pb0-f52.google.com with SMTP id rp16so2161506pbb.25
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WVMa+Gkx1MCRSu4vtyAWjmTJ14k5TM24IDfYBH+xILE=;
        b=jNlmC9xlzxfHYLHWFGJFGmqcT49QFI629dOUjLYu3tOQW2BDLBx534oSZTgvLM/iCF
         J0nAi0tv4arPSztnAM5M0hVtr21Ah1SQcTlRZws9R/7iG4OW+lKlCPGrZW8tUCDSsHQf
         8JjdqhAYd7H7RVekw8n3R7R/FdMCohxIgHi9sEg+3GTcGe1dMFsEDri5Fp1Ies/jjjYw
         fEpX2uU7+UXALHvbgQt7HZeGoXB+EGIcY/bfIikFyWNYT6Lf45LA0f50gKIkF3Ckzv9Z
         RF/mXrFly+A2nW4TQ78FgtYR72JNe+BuTywXnkdxWI54fwOMQIhL5u/Ki5e/pEzTmkNb
         fSpQ==
X-Received: by 10.66.137.109 with SMTP id qh13mr26551256pab.39.1398701565107;
        Mon, 28 Apr 2014 09:12:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pq3sm35910863pbb.57.2014.04.28.09.12.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 09:12:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398693097-24651-2-git-send-email-marat@slonopotamus.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247371>

Hi,

Marat Radchenko wrote:

> When crosscompiling, one cannot rely on `uname` from host system.
> Thus, add an option to use `make MINGW=1` for building MinGW build
> from non-MinGW host (Linux, for example).

The same also applies when cross-compiling for any other platform, no?
The consistent thing to do would be to add an ifdef block like this
for every other platform,version,cpuarch triplet we care about, which
doesn't seem like a great change.

Can't the caller pass in uname_S=MINGW uname_M=x86_64 uname_O=MINGW
uname_R= uname_P= uname_V= (or a single uname_A variable that the
makefile could decompose if that is more convenient)?

Of course that is fussy.  It would be better to infer everything from
CC, since the caller has to specify CC anyway.  Does the output from
"$(CC) -dumpmachine" have the information you need?

Curious,
Jonathan

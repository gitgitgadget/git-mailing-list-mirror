From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: wishlist bugreport: make limit configurable for
 do_fmt_merge_msg (merge.log)
Date: Fri, 20 Aug 2010 14:49:28 +0530
Message-ID: <20100820091925.GE12794@kytes>
References: <20100820020127.GG22469@onerussian.com>
 <20100820064741.GC12794@kytes>
 <20100820081641.GA32127@burratino>
 <4C6E468F.3000800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 20 11:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmNmu-0004pC-FA
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 11:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab0HTJVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 05:21:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44596 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0HTJVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 05:21:18 -0400
Received: by pvg2 with SMTP id 2so1121464pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 02:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AfAyIZMoiJtL1Ksi8/aScBLLbHA22dBQnBtzydlDFMs=;
        b=pq/u2jRSFkNjvDeurAB7/5ZK4WySzDMxmun9U+sb2uSM452ZR/s2kqJnOEt6vlwu8c
         mgluLG2k4ixmsZhaO9NiwtYUx3pitrMiNp26pvXx4sMeT3OrVmWL+F7geNsjp6lVkFZh
         Zqe+owtvkPMLmXGbkwVX3cRTxa/kp1TCJElwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vJ2IJP4OKVnzpX3j1imeT5l6zAnIvK/N3WhinMd66XzlbwW78KJZTeSL8wNdpkpxw3
         Zorp1GGfeHpsConRhzP9MSoAAoRS1yhNuHQ5iI6ouT83B6yx1+c81j29PdOdHs7zzpHn
         C3G7I0gg/wq0k8hYFzgfNjaudnGGi4fAlrCRU=
Received: by 10.114.102.11 with SMTP id z11mr1289157wab.13.1282296078384;
        Fri, 20 Aug 2010 02:21:18 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 33sm4467747wad.6.2010.08.20.02.21.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 02:21:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C6E468F.3000800@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153989>

Hi Johannes,

Johannes Sixt writes:
> Am 8/20/2010 10:16, schrieb Jonathan Nieder:
> > This also provides --log-limit=0 / "[merge] loglimit = 0" to not limit
> > the number of commits summarized at all, which I would expect to
> ...
> >  [verse]
> > -'git fmt-merge-msg' [--log | --no-log] <$GIT_DIR/FETCH_HEAD
> > -'git fmt-merge-msg' [--log | --no-log] -F <file>
> > +'git fmt-merge-msg' [--log | --no-log] [--log-limit=<n>] <$GIT_DIR/FETCH_HEAD
> > +'git fmt-merge-msg' [--log | --no-log] [--log-limit=<n>] -F <file>
> 
> Do we need --log-limit? Why not just --log=42 and --no-log equals --log=0?
> 
> Ditto for the config option:
> 
>   merge.log=42
>   merge.log=0

Ah, just when I was about to post the series. Excellent idea! I'll
drop Jonathan's patch and fixup the series to do this in a few
minutes.

> and for backwards compatibility:
> 
>   merge.log=false  ===  merge.log=0
>   merge.log=true   ===  merge.log=20

I'll use git_config_bool_or_int for this -- we've traded off the
ability to say "infinite" though.

-- Ram

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: serious performance issues with images, audio files, and other "non-code" data
Date: Wed, 12 May 2010 12:15:41 -0700 (PDT)
Message-ID: <m339xxdj71.fsf@localhost.localdomain>
References: <4BEAF941.6040609@puckerupgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John <john@puckerupgames.com>
X-From: git-owner@vger.kernel.org Wed May 12 21:22:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCHVV-00061n-Jc
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 21:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757079Ab0ELTWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 15:22:07 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:35140 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975Ab0ELTWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 15:22:05 -0400
Received: by wwi18 with SMTP id 18so301570wwi.19
        for <git@vger.kernel.org>; Wed, 12 May 2010 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=W+iUrmKbO+ehB4THqhZEkpJ9h5aZY65McWgeriIQ2XM=;
        b=ngLJ7E9SJ/IFlGw/X3w0B88zCM6DeN+hXyOZOM7q3Raf1YjquH319YM5rxsjOhDpaD
         5EEbveksgC+KUjxxsh1EymCu0RMbdRIS+UCHnA/Zn673S0Bts34clE5IfryWZVt/lfmz
         c+5nol3tiZfFBKEH+RvLtv/S4QZVgIVMXfrwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ip9/VM9WbiBKLyCDryn9wBZol9TS3Y6nuVOPcOvPC7wg4ytNfET17+G7xVh39HtDh6
         sgFDFOSpfkp3gXujQoa1dXEwkhY300H92w5GGKJO+w1xGiWsA7NyzegIfQsg8VV10gY+
         GMxi9kHNvp7A8IM/8AVqs4rWmIxAYw4HKhSZQ=
Received: by 10.227.129.10 with SMTP id m10mr7489023wbs.132.1273691742728;
        Wed, 12 May 2010 12:15:42 -0700 (PDT)
Received: from localhost.localdomain (abvw188.neoplus.adsl.tpnet.pl [83.8.220.188])
        by mx.google.com with ESMTPS id u36sm2916374wbv.18.2010.05.12.12.15.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 12:15:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4CJGpa6011052;
	Wed, 12 May 2010 21:17:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4CJGYsU011048;
	Wed, 12 May 2010 21:16:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4BEAF941.6040609@puckerupgames.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146959>

John <john@puckerupgames.com> writes:

> We're seeing serious performance issues with repos that store media
> files, even relatively small files. For example, a web site with less
> than 100 MB of images can take minutes to commit, push, or pull when
> images have changed.
> 
> Our first guess was that git is repeatedly attempting to
> compress/decompress data that had already been compressed. We tried
> these configuration settings (shooting in the dark) to no avail:
> 
>     core.compression 0   ## Docs say this disables compression. Didn't seem to work.
>     pack.depth 1     ## Unclear what this does.
>     pack.window 0    ## No idea what this does.
>     gc.auto 0        ## We hope this disables automatic packing.
> 
> Our guess that re-compression is to blame may not even be valid since
> we can manually re-compress these files in seconds, not minutes.
> 
> Is there a trick to getting git to simply "copy files as is"?  In
> other words, don't attempt to compress them, don't attempt to "diff"
> them, just store/copy/transfer the files as-is?

Search for `delta` attribute, which should be unset for files that you
don't want for git to attempt (binary) delta against, in gitattributes
manpage.

P.S. There is also git-bigfiles project that migth be of interest to
you.
-- 
Jakub Narebski
Poland
ShadeHawk on #git

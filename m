From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Binary files in a linear repository
Date: Mon, 2 Nov 2009 18:48:31 +0300
Message-ID: <20091102154831.GC27126@dpotapov.dyndns.org>
References: <S1754797AbZKBONX/20091102141323Z+268@vger.kernel.org> <8470D32E-2CAA-4E3F-8BA0-B4578372A3C4@jump-ing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Hitter <mah@jump-ing.de>
X-From: git-owner@vger.kernel.org Mon Nov 02 16:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4z89-0002n1-Fh
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 16:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbZKBPrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 10:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755527AbZKBPrc
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 10:47:32 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45044 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbZKBPrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 10:47:31 -0500
Received: by yxe17 with SMTP id 17so4580566yxe.33
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=q5K+QQAxV6NI8Lfy9AewkkMl3gBNkHguTeFcsYlxCSY=;
        b=ClUdozbyDZxuyBzP2FiGdvrJrp0k8uV/4n0JY/0nLB4LE6znQVkHw5hpF+3e8sUamj
         pewwPnea5I8jxOpgEwCsXuQh2UCXljvN3vv+kB+xmXAu45SODP60HKRvqYpTIpjfJKIh
         3ptnifuLSo6czUHASI5G+fr5SAVjv+oEvHK1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rPS74fGvWg1UyqgadFPgAit3qpuTbo7c1r3UY8prTd/B4hEPUv3GGROWHMvRmDoKW+
         U8qV7sRxH+2guTzt6+9+kU4eHT7luOIkhDp0EEnufyyeGwwLFsRjASebOVlNNRaLs68Y
         glJEPq9pZfnKgUh7w0bbrXbhjrOcaKhiFYdV4=
Received: by 10.103.50.29 with SMTP id c29mr2177841muk.61.1257176855924;
        Mon, 02 Nov 2009 07:47:35 -0800 (PST)
Received: from localhost (ppp91-77-227-241.pppoe.mtu-net.ru [91.77.227.241])
        by mx.google.com with ESMTPS id 14sm10166158muo.45.2009.11.02.07.47.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 07:47:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8470D32E-2CAA-4E3F-8BA0-B4578372A3C4@jump-ing.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131917>

On Mon, Nov 02, 2009 at 04:08:25PM +0100, Markus Hitter wrote:
>
> Now I'm thinking about a much simpler solution: Simply declare the  
> current set of files as (a modified) master/com005 and commit them. A  
> "cp $GIT_DIR/master $GIT_DIR/HEAD" followed by a commit would do it.
>
> Now my question: Is it safe to tweak the files in $GIT_DIR this way or 
> will this corrupt the repository?

You probably should use 'git update-ref' if you want to change HEAD
manually. But it seems to me that you do not need even that. All what
you need is:

$ git reset --soft master

and then commit your changes (git reset --soft does not touch the index
file nor the working tree at all).


Dmitry

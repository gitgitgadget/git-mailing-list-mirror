From: Pascal Obry <pascal@obry.net>
Subject: Re: something fishy with Git commit and log from file
Date: Wed, 06 Aug 2008 13:01:32 +0200
Organization: Home - http://www.obry.net
Message-ID: <4899848C.6030800@obry.net>
References: <48997D2E.9030708@obry.net> <20080806104432.GG7121@bit.office.eurotux.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 13:02:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQgn5-00035D-1C
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 13:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbYHFLBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 07:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbYHFLBt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 07:01:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:27858 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbYHFLBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 07:01:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1550379fgg.17
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 04:01:47 -0700 (PDT)
Received: by 10.86.100.19 with SMTP id x19mr350126fgb.15.1218020506904;
        Wed, 06 Aug 2008 04:01:46 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.201.122])
        by mx.google.com with ESMTPS id l12sm3632548fgb.6.2008.08.06.04.01.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Aug 2008 04:01:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.0
In-Reply-To: <20080806104432.GG7121@bit.office.eurotux.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91502>

Luciano,

> If the function doesn't exist, try:
> (gdb) p getwd(malloc(2048))

I got:

(gdb) p (char *)getwd(malloc(2048))
$3 = 0x903680 "/home/obry/dev/repositories/git/AWS"

And this is not the directory I was in. It is the Git root. I was under 
/home/obry/dev/repositories/git/AWS/regtests when running the command.

So definitely a Git bug! Can be reproduced with:

    $ mkdir repo && cd repo
    $ git init
    $ mkdir dir
    $ cd dir
    $ echo file > file
    $ echo log > log
    $ git add file
    $ git commit --file=log
    fatal: could not read log file 'log': No such file or directory

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595

From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related
 subroutines
Date: Mon, 07 Jul 2008 21:24:12 +0200
Message-ID: <48726D5C.9080801@gmail.com>
References: <200807031824.55958.jnareb@gmail.com> <486D36CB.3090400@gmail.com> <200807040145.14724.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFzMu-0001jf-Ss
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 00:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYGGWil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 18:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbYGGWil
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 18:38:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:26515 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbYGGWij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 18:38:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so902859fgg.17
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 15:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=y9CMy+DwbqE8aSQxMRe/cPt30y4z1RKqOOK/45gSYhI=;
        b=UFYVKtEBuzxOtvx31/kxCljRqlXHPuFnfHPJn6VphHgmdPLndwsBXP/x9ZkQQZMWWc
         vFoB8XXAkl+lAene6TzkeQpEr6GXmmIUxpb5GSOCbHGaCKnW7FHZ1rdeAJVFlZH0IXws
         ry3VnY/MUEkqYFO6PS3IZpkodlD/U4WGsJwck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=jaCmcObxBp0TXko8rKvAADi1oAo07/ijx8HjAC8E0IFCHCr03JHHq91QnW7M5tnIHF
         cDG+otEWqpl6ni933tuwIkc5h5mEZf9T3omCZy6kwK4m5IVGN0rnPoePrVkW0EeTZCi/
         cnYz/k83jKYsG6zq2McI311rmA5zq+0UlxiKs=
Received: by 10.86.33.10 with SMTP id g10mr4750186fgg.29.1215470318705;
        Mon, 07 Jul 2008 15:38:38 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.220.244])
        by mx.google.com with ESMTPS id 4sm5564226fgg.9.2008.07.07.15.38.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 15:38:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807040145.14724.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87663>

Jakub Narebski wrote:
> I'd rather have both functional (of sorts) and object interface.

I wouldn't, since it makes the code more complicated.  Having an
object-oriented interface is cleaner (in this case), and it doesn't make
it more complicated to use; hence I don't think there's any need for a
functional interface.

> Git::Repo / Git::Config could use methods / subroutines from Git.pm;

I don't think that's possible, since Git.pm has a pretty long-running
(and complicated) instantiation method, whereas Git::Repo has (and must
have) instantaneous instantiation (without system calls).  Also, Git.pm
is so strange (design-wise) that I'm not very happy with depending on it
as it is.  I'll write more about that later though.

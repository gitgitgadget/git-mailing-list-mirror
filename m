From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Re: Truncating and cleaning a imported git repositary to make it more usable
Date: Sat, 29 Mar 2008 13:47:01 +0000
Message-ID: <b2cdc9f30803290647n31bd6db5r4f346360989c2dcd@mail.gmail.com>
References: <1206707716.9819.15.camel@malory>
	 <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>
	 <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com>
	 <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com>
	 <47ED204E.3020602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Mar 29 14:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfbPZ-0004II-3G
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 14:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbYC2NrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 09:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbYC2NrD
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 09:47:03 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:48449 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbYC2NrC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 09:47:02 -0400
Received: by rv-out-0910.google.com with SMTP id k20so403571rvb.1
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 06:47:01 -0700 (PDT)
Received: by 10.141.15.19 with SMTP id s19mr2205317rvi.75.1206798421737;
        Sat, 29 Mar 2008 06:47:01 -0700 (PDT)
Received: by 10.140.161.13 with HTTP; Sat, 29 Mar 2008 06:47:01 -0700 (PDT)
In-Reply-To: <47ED204E.3020602@viscovery.net>
Content-Disposition: inline
X-Google-Sender-Auth: 757aa1ac55177cb8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78466>

On Fri, Mar 28, 2008 at 4:43 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Alex Bennee schrieb:
>  You really shouldn't do it this way, unless you do it on a ramdisk. Better
>  use an --index-filter. This is modeled after the last example in the man
>  page (and, of course, untested):
>
>  git filter-branch --index-filter \
>         'git ls-files -s |
>          grep -v "      big_dira" |
>          grep -v "      big_dirb" |
>                 GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
>                         git update-index --index-info &&
>          mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
>
>  where the space before big_dir is actually a literal TAB!

Hmm thats odd. Despite having successfully run the filter my repo is
still the same size. git-fsck --full shows loads of dangling commits
but I'm guessing because the repo is packed they don't get dropped. Is
it possible to repack the whole repo or do you have to manually unpack
the packs and re-pack?


-- 
Alex, homepage: http://www.bennee.com/~alex/

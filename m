From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git add / update-cache --add fails.
Date: Wed, 27 Apr 2005 19:30:59 +0200
Message-ID: <20050427173059.GE22956@pasky.ji.cz>
References: <200504260726.04908.rhys@rhyshardwick.co.uk> <E1DQcOc-00054l-00@gondolin.me.apana.org.au> <87ll74go7o.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 19:28:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQqK6-00019Y-1u
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 19:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVD0RcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 13:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVD0Rb5
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 13:31:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17830 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261821AbVD0RbL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 13:31:11 -0400
Received: (qmail 8014 invoked by uid 2001); 27 Apr 2005 17:30:59 -0000
To: Ed L Cashin <ecashin@coraid.com>
Content-Disposition: inline
In-Reply-To: <87ll74go7o.fsf@coraid.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 27, 2005 at 06:48:43PM CEST, I got a letter
where Ed L Cashin <ecashin@coraid.com> told me that...
> Herbert Xu <herbert@gondor.apana.org.au> writes:
> 
> > Rhys Hardwick <rhys@rhyshardwick.co.uk> wrote:
> >> 
> >> rhys@metatron:~/repo/learning.repo$ strace update-cache --add w1d4p1.c
> > ...
> >> open("w1d4p1.c", O_RDONLY)              = -1 ENOENT (No such file or 
> >> directory)
> >
> > The file that you're trying to add doesn't exist.
> 
> Maybe the user should be informed as soon as update-cache knows that?
> 

> update-cache.c: 11388582a830a6161d1c769aa8616bed6f593b8a
> --- a/update-cache.c
> +++ b/update-cache.c
> @@ -98,6 +98,7 @@ static int add_file_to_cache(char *path)
>  
>  	fd = open(path, O_RDONLY);
>  	if (fd < 0) {
> +		fprintf(stderr, "update-cache Error: %s\n", strerror(errno));
>  		if (errno == ENOENT) {
>  			if (allow_remove)
>  				return remove_file_from_cache(path);

FWIW, I have this in my tree for some time already. :-)

> By the way, I created that patch with "git diff" in my git-pasky
> working directory.  Strangely, I had to redirect standard error to the
> same place as standard output in order to get the filename in the diff
> output.  I didn't check why the filename is on standard error,
> though.

Interesting. Anyway, you are apparently using some quite antique
git-pasky version.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

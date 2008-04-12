From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Intricacies of submodules
Date: Sat, 12 Apr 2008 12:02:25 +0800
Message-ID: <46dff0320804112102t52a60072rc97c772a1e74f597@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu> <47FBDA77.2050402@et.gatech.edu>
	 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
	 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
	 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
	 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
	 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
	 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
	 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
	 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Roman Shaposhnik" <rvs@sun.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 06:03:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkWxM-0000mm-DQ
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 06:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbYDLEC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 00:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbYDLEC1
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 00:02:27 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:59228 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYDLEC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 00:02:27 -0400
Received: by an-out-0708.google.com with SMTP id d31so180509and.103
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 21:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=a6SZCN3TdlXoFKx36/mZm3Qkq2f8LcUQ82JRU/VafZk=;
        b=oUw5q+ezs/FdMviujO22Yeuum51K3JFWzBTuhFJ+CEiIcUsmkI/9hQXUI3P4rwT76XGABcDiCY/eyAnrv5EUHuBeiATjqEalKlpfKI6tdKSO+gSQ2ldcESS4jM0IqNC0vNMLJGJ1EA2CezufOJMwCo1Qw+erSABKWT8Drf15jOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cyrk79xBay2QnhhJbM8DYFR9o6lDW+IO0PvkxXXQxMUR7SINQiJri5n8ep2cAb6SUQMxwI8llzEjfGh1kyx/Ba1SZ4hGnm+qInXxKSQUBRd3sA1ITpFLhKoyl3kVnWZj3l+K9Zvyif/8Rx/hqM/+P5g2Bh57Cj9sf08HbmodWlw=
Received: by 10.100.46.10 with SMTP id t10mr257867ant.156.1207972945529;
        Fri, 11 Apr 2008 21:02:25 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 11 Apr 2008 21:02:25 -0700 (PDT)
In-Reply-To: <7v63uqz265.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79327>

On Thu, Apr 10, 2008 at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  The original discussion that led to the current implementation dates back
>  in May-June timeframe of 2007.  I would not be surprised if not all of the
>  good ideas were incorporated in the current implementation.  For example,
>  one thing that we may want to do is to record what contents we've seen in
>  the .gitmodules file in order to prime each entry in .git/config, so that
>  we can give users a chance to adjust what is in .git/config when we notice
>  the entry in .gitmodules has changed.
>
>  For example, consider that .gitmodules said the submodule should be taken
>  from repository URL git://A.xz/project.git when you cloned.  You may have
>  used the given URL as-is to prime your .git/config, or you may have chosen
>  to use http://A.xz/project.git/ for networking reasons.
>
>  After working with the project for a while (i.e. you pull and perhaps push
>  back or send patches upstream), .gitmodules file changes and it now says
>  the repository resides at host B.xz because the project relocated.  You
>  would want the next "git submodule update" to notice that your .git/config
>  records a URL you derived from git://A.xz/project.git/, and that you have
>  not seen this new URL git://B.xz/project.git/, and give you a chance to
>  make adjustments if needed.

I think this should be done if "git submodule update" fails. The
reason it fails may be different, such as newest commits not pushed
out and the subproject relocated etc. So it can only given some hints
with "maybe".

However, how to detect the url has changed in .gitmodules? Compare the
latest two version of .gitmodules?

And if only the protocol or domain changes of the submodule between
$GIT_CONFIG/config and .gitmodules, i think the
"url.<usethis>.insteadof = <otherurl>" form introduced in v1.5.5 is
more helpful.

>
>  After that happens, if you seeked to an old version (perhaps you wanted to
>  work on an old bug), .gitmodules file that is checked out of that old
>  version may say the "upstream" is at A.xz, but the entry in .git/config
>  may already be based on B.xz.  But because you have already seen this old
>  URL in .gitmodules, you may not want to get asked about adjusting the
>  entry in .git/config merely because you checked out an old version.  What
>  this means is that it is not enough to just record "What the current URL
>  you chose to use is" in .git/config (which is obvious), and it is also not
>  enough to record "what URL .gitmodules had when you made that choice", but
>  you would also need to record "What URLs you have _seen_ when making that
>  choice".
>

When bug happens, i only care the commit in the index of submodule and
wheter i can check out the old submodule commit. However, does it
really matter that what the url of the submodule is?


-- 
Ping Yin

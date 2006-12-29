From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: read-for-fill and caching in gitweb (Re: kernel.org mirroring)
Date: Fri, 29 Dec 2006 13:47:09 +0100
Message-ID: <200612291347.10805.jnareb@gmail.com>
References: <46a038f90612281245s52bdd868h8c421951c7abeb84@mail.gmail.com> <200612291140.46909.jnareb@gmail.com> <46a038f90612290346n35386e14g922465d66beaf5ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Robert Fitzsimons" <robfitz@273k.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Jeff Garzik" <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 29 13:44:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0H61-0003HX-9m
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 13:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbWL2MoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 07:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbWL2MoR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 07:44:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:35346 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbWL2MoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 07:44:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4376432uga
        for <git@vger.kernel.org>; Fri, 29 Dec 2006 04:44:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XriLP4o6gdmV6cgtcWOzuvCq7gZOq8NygnHsFtBo+l3wUpwmH7QyabXRCULa1U6rRsLZXMt0+NK1QGXeA9XraUNBM/PZ/0XvCvBV0YyouA5IsHv++mCW9Ru12fxQp6+BnAMDr7LuaqSPv5B8hkErEH8ZE5vnUsC6gdViNazEjEg=
Received: by 10.67.20.3 with SMTP id x3mr9377628ugi.1167396253157;
        Fri, 29 Dec 2006 04:44:13 -0800 (PST)
Received: from host-81-190-24-56.torun.mm.pl ( [81.190.24.56])
        by mx.google.com with ESMTP id i39sm26094091ugd.2006.12.29.04.44.12;
        Fri, 29 Dec 2006 04:44:13 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90612290346n35386e14g922465d66beaf5ab@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35591>

Martin Langhoff wrote:
> On 12/29/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> It is simply the case that new features cost more. Namely in earlier
>> versions of gitweb Last Change time was taken from HEAD (from current
>> branch), in newer we check all branches (using git-for-each-ref).
>> For published public repository it migh make sense to pack also heads
>> (make them packed refs).
> 
> I haven't been using packed refs at all, but it sounds like it's a
> single file. So we can stat just that file rather than ask questions
> about the heads themselves. That makes checking for if-modified-since
> cheap as well.

That I think would work _only_ for the working repository. For 
publishing bare repository you push into (or which is a mirror of some 
other repository) I think stat $GIT_DIR/packed-refs would return date
of last push (last mirror), not when repository was last committed to...
 
>> I was thinking about making this a gitweb %feature, allowing gitweb
>> administrator to chose if Last Change is taken from all branches
>> (as it is now), from HEAD (as it was before), or from given branch
>> (for example master).
> 
> I think the natural thing is to check all heads (doing it on the cheap
> on packed-refs repos) and provide tuning tips. in this case "use
> packed refs" which I guess will become the default eventually.

...but this could be included in above %feature.

-- 
Jakub Narebski
Poland

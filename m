From: Noel Grandin <noel@peralex.com>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 13:21:25 +0200
Message-ID: <4281EAB5.3020006@peralex.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1115810485-11173-396"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 13:14:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVpAW-0006B4-UC
	for gcvg-git@gmane.org; Wed, 11 May 2005 13:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVEKLVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 07:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVEKLVx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 07:21:53 -0400
Received: from mail.peralex.com ([168.210.54.172]:44493 "EHLO mail.peralex.com")
	by vger.kernel.org with ESMTP id S261965AbVEKLVr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 07:21:47 -0400
Received: from [192.168.1.230] (noel.ct [192.168.1.230])
	by mail.peralex.com (8.13.3/8.13.1) with ESMTP id j4BBLPuY036486;
	Wed, 11 May 2005 13:21:25 +0200 (SAST)
	(envelope-from noel@peralex.com)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc40320505100800426d38ca@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Scanned-By: MIMEDefang 2.42
X-Synonym: Copied by Synonym (http://www.modulo.ro/synonym) to: mailbackup@peralex.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1115810485-11173-396
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Note that eclipse in particular has a fairly complicated repository 
provider interface.
The subversion plugin developers (the subclipse project) took quite a 
while to implement their stuff.
Basing your stuff off of their code would be a good idea.

Also, they worked in 2 stages - in the first stage, they created 
something called the JavaHL interface, behind which they talked to the 
subversion C libraries using JNI.
Then they created a pure-java implemenation of the subversion C 
libraries which also implemented the JavaHL interface, allowing them to 
compare and contrast the behaviour.

Regards,
   Noel Grandin


Jon Seymour wrote:

>I have been experimenting with pure-Java implementation of GIT
>concepts with a goal of eventually providing plugins to Eclipse to
>allow the Eclipse GUI to interact with GIT repositories.
>
>One thing I noticed when doing this is that the present index/cache
>structure is rather arbitrary and the optimum index structure is
>determined by the structure of the tools that use a GIT repository
>rather than the structure of the GIT repository itself.
>
>To give a concrete example: the cache currently contains most of the
>posix stat structure primarily to allow quick change detection. In the
>Java world, most of the posix stat structure is not directly
>accessible via the pure-Java file system abstractions. However, for
>most purposes detecting changes to files modification time and file
>size would be enough. Given this is the case, a Java-GIT client
>doesn't need to bother getting access to a posix stat structure and
>could therefore get away with a simpler  index structure, provided it
>doesn't need to interoperate with a 'C'-GIT client that shared the
>same workspace. A Java-GIT client might also choose to represent an
>index cache as a complex serialized Java object graph or (perhaps) an
>XML document.
>
>Another example: I can imagine a variant of the index file structure
>that recorded all the parents which have been merged into the cache
>and automatically include this information when performing the commit.
>
>The point is that many different index file structures are possible
>and will be determined in part by the tooling created in the porcelain
>layer - there really is no one true index file format as there is a
>one true repository format. Different tools can use different index
>file formats and still interoperate at the repository level because
>only the repository format needs to have a solid, unchanging
>definition.
>
>Currently the GIT stack is structured as follows:
>
>cogito
>git-core 
>
>I think it would be worthwhile if care was taken to draw a distinction
>between the repository and the cache aspects of the git core, perhaps
>even going to the extreme of moving all knowledge of the  cache into
>cogito itself. By clearly drawing this distinction, we will more
>easily enable the creation of different kind of tools sets atop the
>foundation of the GIT repository format.
>
>e.g., either:
>
>cogito
>git-cache
>git-respository
>
>or:
>
>cogito-tools
>cogito-cache
>git-repository
>
>Anyway, I offer this as food for thought - chew or flame away as appropriate!
>
>jon.
>  
>


NOTICE: Please note that this email, and the contents thereof, 
are subject to the standard Peralex email disclaimer, which may 
be found at: http://www.peralex.com/disclaimer.html

If you cannot access the disclaimer through the URL attached 
 and you wish to receive a copy thereof please send 
 an email to email@peralex.com

------------=_1115810485-11173-396--

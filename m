From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Fri, 6 May 2005 20:20:25 -0400 (EDT)
Message-ID: <2637.10.10.10.24.1115425225.squirrel@linux1>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 02:14:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUCxE-0008TJ-GV
	for gcvg-git@gmane.org; Sat, 07 May 2005 02:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVEGAUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 20:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVEGAUd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 20:20:33 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:48286 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261322AbVEGAU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 20:20:26 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050507002025.ZONH3701.simmts7-srv.bellnexxia.net@linux1>;
          Fri, 6 May 2005 20:20:25 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j470KMVh019095;
	Fri, 6 May 2005 20:20:22 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 6 May 2005 20:20:25 -0400 (EDT)
In-Reply-To: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2005 7:35 pm, Junio C Hamano said:

Hi Junio,

> This is an implementation of the idea floated on the GIT list a couple
> of days ago to archive really old history on a separate directory, even
> on a read-only DVD ROM media.

David Lang should get the credit for the idea.

>  int has_sha1_file(const unsigned char *sha1)
>  {
> -	char *filename = sha1_file_name(sha1);
>  	struct stat st;
> +	char *filename = find_sha1_file(sha1);
> +	if (!filename)
> +		return 0;
>
>  	if (!stat(filename, &st))
>  		return 1;

has_sha1_file can be reduced to:


int has_sha1_file(const unsigned char *sha1)
{
       return (!!find_sha1_file(sha1));
}


Sean



From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Wed, 19 Dec 2007 17:07:50 -0800
Message-ID: <7vr6hirx5l.fsf@gitster.siamese.dyndns.org>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	<20071218204623.GC2875@steel.home>
	<200712182224.28152.jnareb@gmail.com>
	<20071218222032.GH2875@steel.home>
	<Pine.LNX.4.64.0712182239500.23902@racer.site>
	<56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
	<alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
	<56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
	<Pine.LNX.4.64.0712191334460.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 20 02:08:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J59tz-0002Sp-5h
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 02:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbXLTBIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 20:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbXLTBIT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 20:08:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbXLTBIS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 20:08:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CE54381F3;
	Wed, 19 Dec 2007 20:08:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BFD781E2;
	Wed, 19 Dec 2007 20:08:00 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68964>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/cache.h b/cache.h
> index 39331c2..83a2c31 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -225,6 +225,7 @@ extern char *get_index_file(void);
>  extern char *get_graft_file(void);
>  extern int set_git_dir(const char *path);
>  extern const char *get_git_work_tree(void);
> +extern const char *get_current_prefix(void);
>  
>  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
>  
> diff --git a/setup.c b/setup.c
> index b59dbe7..fb9b680 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -3,6 +3,12 @@
>  
>  static int inside_git_dir = -1;
>  static int inside_work_tree = -1;
> +static const char *current_prefix;
> +
> +const char *get_current_prefix()
> +{
> +	return current_prefix;
> +}

Didn't you just make libification harder?

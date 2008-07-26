From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH 3/7] builtin-help: make list_commands() a bit more generic
Date: Sat, 26 Jul 2008 13:28:39 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807261319310.16184@harper.uchicago.edu>
References: <cover.1217037178.git.vmiklos@frugalware.org>
 <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
 <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
 <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
 <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 20:29:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMoWg-0000Ge-HA
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 20:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbYGZS2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYGZS2w
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 14:28:52 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:45813 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbYGZS2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 14:28:51 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6QISdUc026637;
	Sat, 26 Jul 2008 13:28:40 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6QISdTl016538;
	Sat, 26 Jul 2008 13:28:39 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90269>

On Sat, 26 Jul 2008, Miklos Vajna wrote:

> -static void list_commands(void)
> +void list_commands(const char *prefix, const char *title)
>  {
> -	unsigned int longest = load_command_list(NULL);
> +	unsigned int longest = load_command_list(prefix);
>  	const char *exec_path = git_exec_path();
>  
>  	if (main_cmds.cnt) {
> -		printf("available git commands in '%s'\n", exec_path);
> +		printf("available %s in '%s'\n", title, exec_path);
>  		printf("----------------------------");
>  		mput_char('-', strlen(exec_path));
>  		putchar('\n');

Should this be

	printf("available %s in '%s'\n", title, exec_path);
	printf("----------------");
	mput_char('-', strlen(exec_path) + strlen(title));
	putchar('\n');

?

(same question goes for the if(other_cmds.cnt) block, too)

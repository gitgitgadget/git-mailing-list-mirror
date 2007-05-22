From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb.perl - Optionally send archives as .zip files
Date: Tue, 22 May 2007 14:28:28 +0200
Message-ID: <20070522122828.GJ4489@pasky.or.cz>
References: <11796760064103-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Tue May 22 14:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqTTr-0004Or-MC
	for gcvg-git@gmane.org; Tue, 22 May 2007 14:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762493AbXEVM2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 08:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762267AbXEVM2b
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 08:28:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55357 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757430AbXEVM2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 08:28:30 -0400
Received: (qmail 27906 invoked by uid 2001); 22 May 2007 14:28:28 +0200
Content-Disposition: inline
In-Reply-To: <11796760064103-git-send-email-mdl123@verizon.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48099>

 Hi,

On Sun, May 20, 2007 at 05:46:46PM CEST, Mark Levedahl wrote:
> git-archive already knows how to generate an archive as a tar or a zip
> file, but gitweb did not. zip archvies are much more usable in a Windows
> environment due to native support and this patch allows a site admin the
> option to deliver zip rather than tar files. The selection is done by
> inserting
> 
> $feature{'snapshot'}{'default'} = ['x-zip', 'zip', ''];
> 
> in gitweb_config.perl.
> 
> Tar files remain the default option.
> 
> Signed-off-by: Mark Levedahl <mdl123@verizon.net>

Acked-by: Petr Baudis <pasky@suse.cz>

Maybe the code should decide based on program value being 'zip' rather
than suffix value, but that's just dubious nit-picking.

> @@ -3912,19 +3914,26 @@ sub git_snapshot {
>  		$hash = git_get_head_hash($project);
>  	}
> 
> -	my $filename = decode_utf8(basename($project)) . "-$hash.tar.$suffix";
> +	my $git = git_cmd_str();
> +	my $name = $project;
> +	$name =~ s/\047/\047\\\047\047/g;

By the way, this really looks like an entry to our very own would-be
"git obfuscation of the month" contest. Why did whoever made the code
not just write that ' there?  (I know it's been in the original code
too.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett

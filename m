From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 1/2] Ensure consistent usage of mergetool.keepBackup
	in git
Date: Fri, 10 Apr 2009 00:43:29 -0700
Message-ID: <20090410074327.GA9369@gmail.com>
References: <20090409153033.GN23604@spearce.org> <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl> <20090410032731.GA1545@gmail.com> <49DEEE22.5030500@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Fri Apr 10 09:46:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsBRb-0002sz-ML
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 09:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbZDJHnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 03:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbZDJHnq
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 03:43:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:24134 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbZDJHnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 03:43:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so970127rvb.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=v8AUloMPjRXtYiNc9zELsmbJaaecUuzcgGo7e0yvVkA=;
        b=IEPH5ll8gbbccDIo34VchWUIJgMmI2ZFKOQbSGPy+1VR2Svdi7ghN9kHymubN+Cp/4
         g6NkwW2ZNKb/Enna/5ih6oS8nBSNghvnaMyK0n2ylFrIJotcNKp9bmJvc4B2Qj9pl0MS
         7K1kpD6WMCXbT7creuZgb49WqNJ9pR3XDwfac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oUmwiAaN6zaqIeAdTML6FRc8cEl+sTo3p5jiJelZwWCyLMnOdLqlhKVFNTCMpDIsdP
         WG0NRI8aNKUnL9ydiTSyyMo4NRFmZ7yT84J/N4TzPu2v4GudAfCCfrLhnylq9SpaJq7g
         aoCbP7FBeE533DAmRYr0DkHyVwFcgsa0aNCiQ=
Received: by 10.114.192.3 with SMTP id p3mr1818550waf.25.1239349425031;
        Fri, 10 Apr 2009 00:43:45 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n40sm1094813wag.13.2009.04.10.00.43.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Apr 2009 00:43:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49DEEE22.5030500@pelagic.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116243>

On  0, "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl> wrote:
> David Aguilar wrote:
> 
> I patched it this way because contrib/completion/git-completion.bash and
> Documentation/config.txt talk about mergetool.keepBackup while only
> contrib/difftool/git-difftool.txt talks about merge.keepBackup. That
> seemed the most logical way of doing it.
> 
> I agree that some users might be surprised after this patch, otoh: I was
> quite surprised that I still had turds even when I set
> mergetool.keepBackup, which is what the documentation told me to do :-)
> Do we really want to keep using 2 names for the same thing?
> 
> [rebasing now...]
> 
> I'm seeing the following grep on pu:
> 
> contrib/completion/git-completion.bash:	mergetool.keepBackup
> Documentation/config.txt:mergetool.keepBackup::
> git-gui/lib/mergetool.tcl:if {[is_config_true merge.keepbackup]} {
> git-gui/git-gui:set default_config(merge.keepbackup) true
> git-gui/git-gui.sh:set default_config(merge.keepbackup) true
> git-mergetool.sh:merge_keep_backup="$(git config --bool merge.keepBackup
> || echo true)"
> 
> So it seems that merge.keepBackup is actually used consistently in the
> code while the completion and documentation talk about mergetool.keepBackup.
> 
> Shall I just patch the completion and documentation instead?


Oh wow thanks for your investigation.
It /seems/ like the docs and completion should be updated.
That's funny.. I guess it's so subtle it just passed by
unnoticed this whole time.

-- 

	David

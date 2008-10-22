From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] rehabilitate 'git index-pack' inside the object store
Date: Wed, 22 Oct 2008 21:57:50 +0700
Message-ID: <fcaeb9bf0810220757w678e303cl6237eb8908261cba@mail.gmail.com>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home>
	 <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
	 <alpine.DEB.1.00.0810211856090.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 22 16:59:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsfB4-00036C-HD
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 16:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbYJVO5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbYJVO5y
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 10:57:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:27153 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbYJVO5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 10:57:52 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1443927nfc.21
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9t7Hxwi8VMr1EDXOLdVxHze3Zuqk/KgJ8IEm/FhoOe4=;
        b=Uw5UDEAh/2g2Me7Im2g6rWCyxF0E8EwNZt51pUZHZyBZJ1uL5yDNfWJyPsp4SHxTUS
         083ydPxMumlBtNYuvYn/B9PDKGp4SsOeIH+WUTFqOnD3eZNh3PtuzVhdaFXim7hr0QGT
         OHFkClUNvrXB9C+G3x7wk/1xn41UbUWw6Rhss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lcr2d//WXKlDt+l0v51sTQgGbJzeD1iwEFd0iso6H2mKRWr1rEDZRA3/yiyVqDJAJj
         YtE89tLABtfJd4FN7ZxwUF9ojgcXkV+8QoByJscvi8HDVBmbpgFxNm0t+A3xAeiLBOWb
         2sL5d+veZ4bzvImOfkwea8GIU6eXz92N91JVM=
Received: by 10.86.61.13 with SMTP id j13mr1050774fga.69.1224687470803;
        Wed, 22 Oct 2008 07:57:50 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Wed, 22 Oct 2008 07:57:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0810211856090.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98873>

On 10/22/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  So I propose this change in semantics:
>
>  - setup_git_directory_gently(): rename to discover_git_directory(),
>   and avoid any chdir() at all.
>  - setup_git_directory(): keep the semantics that it chdir()s to the
>   worktree, or to the git directory for bare repositories.
>
>  Using _gently() even for RUN_SETUP builtins should solve the long standing
>  pager problem, too.

Also, from [1] may be only set default git_dir in setup_git_env()
after setup_git_directory() has been called and before
setup_work_tree() is called (if any)? If not, die().

[1] http://article.gmane.org/gmane.comp.version-control.git/98849
-- 
Duy

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] vcs-svn: extend svndump to parse version 3 format
Date: Tue, 12 Oct 2010 17:56:46 -0500
Message-ID: <20101012225646.GF15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-6-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 01:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5npL-0007Z8-53
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 01:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173Ab0JLXAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 19:00:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35819 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab0JLXAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 19:00:07 -0400
Received: by qwa26 with SMTP id 26so688903qwa.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qQ4Ugg7GdXD/NT1IJhy2FrgeE3krAuV+3aKUBW1e8oI=;
        b=D0qpQB7u7nwGXXRKwc10lTldztbXvlOGqBO2pUOmxaoy86gKGoFJPkyTbs5jAoAA9L
         8YJmS81drH5tY9T9tQlLtMVCttB9gH2WSYhEmPVjaMSCAUc+Q7ZPEco2lgWxL+HQbz1L
         40EzaufzaW/kfyqBpaBHvEcEWW8vviTet7d58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VchtobKI9HXc+mnry4yq2sN2pBPnmORQH0dSDfkqLymUvTwhTfC06/F3i7n3NStCj0
         A2jlT/Q9MyhfcmbC1ukMTsGnmetsgPAgdPbSdxtXz5NHoRzpuTGmisSPBKznAP5D1l0C
         XRHHgUfA29i00HqdDlbOQU0JQK0loYAeiK5kA=
Received: by 10.229.182.82 with SMTP id cb18mr3847903qcb.286.1286924406558;
        Tue, 12 Oct 2010 16:00:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id t17sm5787733qcp.2.2010.10.12.16.00.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 16:00:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286891424-2067-6-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158891>

David Barr wrote:

> Added 1 new dump header, SVN-fs-dump-format-version.
> Added 6 new node headers:

Style: using the imperative mood, present tense would make this
fit better with other log entries.

> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -27,6 +27,9 @@
>  #define LENGTH_UNKNOWN (~0)
>  #define DATE_RFC2822_LEN 31
>  
> +#define MD5_HEX_LENGTH 32
> +#define SHA1_HEX_LENGTH 40

I was surprised to find this is not in any existing header.  Looks
good to me.

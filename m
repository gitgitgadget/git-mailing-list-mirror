From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] vcs-svn: improve reporting of input errors
Date: Tue, 4 Jan 2011 04:16:05 -0600
Message-ID: <20110104101605.GA24844@burratino>
References: <20101228104503.GA5422@burratino>
 <20101228105410.GD13360@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 11:16:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa3wI-0005Cq-61
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 11:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109Ab1ADKQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 05:16:21 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47689 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1ADKQU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 05:16:20 -0500
Received: by yxt3 with SMTP id 3so5564616yxt.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 02:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WWJS6edNmGb1m3HUYKMNtqm36lMEvQlRkANzDctX5F0=;
        b=anvf60DXlCiCfFeOxgd2s44o1/vHznKwV2qKe7b6CfPmHgWgxnychcnws66OUsB6Sg
         Rt3BPX4yOklOxOxIP4r0L3spPpeyyLo0/XiFUJenOtQTncxs4eeb9N84iXjOSs+BbbKV
         Lg8CUvHrW2/rI6tDm/fjBELDLG5m2Secb7Cs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=W+jqWVP5oYSaZAKIdAA3rPqrrYBCjXzsdOy7rcmGUx2dycRy1HbwXKr1uhzoClbsD1
         K2vGODuHjBwC5dCf+quoCE0TgOSj9l7hdM4r3rstzkyW5A6k/PhSDwS8DldUZD0wU3Si
         ZU+tvuEwl4i5SN/BbOs6NN11ZjsyN02pGIDko=
Received: by 10.236.105.180 with SMTP id k40mr10659776yhg.93.1294136179906;
        Tue, 04 Jan 2011 02:16:19 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id i60sm12952377yhj.17.2011.01.04.02.16.16
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 02:16:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101228105410.GD13360@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164482>

Jonathan Nieder wrote:

> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -107,20 +107,37 @@ static void init_keys(void)
[...]
>  		} else if (!strncmp(t, "V ", 2)) {
>  			len = atoi(&t[2]);
>  			val = buffer_read_string(len);
> +			if (!t)
> +				die_short_read();

This should have said "if (!val)".  Sorry for the confusion.

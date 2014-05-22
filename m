From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 8/8] read-cache: inform the daemon that the index has
 been updated
Date: Thu, 22 May 2014 12:38:10 -0400
Organization: Twitter
Message-ID: <1400776690.1933.8.camel@stross>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
	 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
	 <1399979737-8577-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 18:38:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnW0e-0002Wp-Mo
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 18:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbaEVQiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 May 2014 12:38:20 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:50883 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbaEVQiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 12:38:19 -0400
Received: by mail-qg0-f43.google.com with SMTP id 63so6220335qgz.30
        for <git@vger.kernel.org>; Thu, 22 May 2014 09:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=2EXuhJywou63zVftK6tCtf2KKJFaIO/Sg39pqEpkb0M=;
        b=ZnJJUSEzIjNUqUoMQLGFH/KmniZbR8EUZHnsO/oT6WRiy2qZ1HjeHNjEBYRAbbPttG
         sXd41FhXC01zftMva5LI5MvMMjk5xYBq3XTU3/R1zcyH7xmBTTq0PdFAa4P4yLeEpuFH
         lYs1Sm1Cu8sKD3IMD1K3xc88L59Pphers/2hIrBbsk0X/8dXM6Of8wyTl5fJPPkkKLJV
         m3VHjUrSHjah6DeP+XZrKiFqfMcRecVM7/Y9CwvbN1bq75+r56eSS6WzPG7haaoDZ/M9
         +RqEqnkkAXxRKjKsjjZyyhKW02QZ91eE/0h8DReAvD3pVkzVugQw+0O4v9oZ4eJth+Qs
         YLtw==
X-Gm-Message-State: ALoCoQmysRgT0qCoyOPxUWCvtvzMtImTMzoDWn7ANCyZqDbeJkloXcJFk1mMzxy+hyuXHDX5AA99
X-Received: by 10.140.22.42 with SMTP id 39mr69685518qgm.63.1400776694591;
        Thu, 22 May 2014 09:38:14 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id g10sm475125qai.5.2014.05.22.09.38.11
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 09:38:12 -0700 (PDT)
In-Reply-To: <1399979737-8577-11-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249914>

On Tue, 2014-05-13 at 18:15 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
> +		if (run_command(&cp))
> +			warning(_("failed to start read-cache--daemon: %s"),
> +				strerror(errno));

errno is not always (ever?) set, so if read-cache--daemon is missing,
you get:
warning: failed to start read-cache--daemon: Success

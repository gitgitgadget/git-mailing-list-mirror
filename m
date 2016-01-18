From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 5/5] ls-remote: add support for showing symrefs
Date: Mon, 18 Jan 2016 22:48:45 +0100
Message-ID: <20160118214845.GH7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
 <xmqqoacid4zh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, bturner@atlassian.com,
	pedrorijo91@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 22:48:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLHey-00080M-4Z
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 22:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbcARVsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 16:48:21 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36239 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbcARVsT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 16:48:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so19128338wmf.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RkH4u3j0bjbuvgfYSIg/uWBvLqkxonHBCJMH7poPQ+4=;
        b=J/FlZWCGDRa1kgbu5NvM4PLCzsaqXvKxb0M2d6RN/NY0HLBZxLaUPypD+6TrkO+Tp4
         QGERd9jUSxPSLSgKakufjY/wxmklPQlCwJ9IkC5+T6Nj6rOJsE9kQAi6Van+yWkyugVS
         QKYrmIj0WkthqSAXa4bNcwmWdGY63K+/u/Elp+qTTZnuRHYOLw2lZ11U/aUbJ1T0rAvA
         BEtxJUD4O2vVZAeyJY8CSHfmczS58P+oAarJYiP4bMbkHq9LKQUPhUICiGeWxnZp9M8W
         Wyr8C0agT//jScnYq2QHLoOEwSxyx7VPfQZ9VAYQD69JrluMXkyGZMH2s0ceWCDlbj58
         xy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RkH4u3j0bjbuvgfYSIg/uWBvLqkxonHBCJMH7poPQ+4=;
        b=X30OMcwcdUW3LeBLmAbp8jBIFxI7W/uPY3oyLGZ72wVUtg+ffLqygniQgIysn0wSYn
         pkR+deP+qXHaj8Ap9IGyfIxLYNWvPr9F8T+86cqRGtZERBGWOPn6uR+9icnuRsyCu98e
         xA+ePcboRgxVj+MzjRzOL34UhmhntRQSqePAjlxt/8AM7fzNYaFRjXhKn4MK2t8XLg/e
         MqllbnxSHd3hmqdqfaHLRrgtjU6IXEN8MQyhs4ux/NKNh6aQMHOtoz0g7T4404Xjs/Sq
         kn0dQtZksPvNn2k8ByVY8stdZpoUolDuwu7tFD1E3dYp8x2JX4mBFDCNkUFbLwILts1Q
         icQQ==
X-Gm-Message-State: AG10YOQpers7WgDsUzY8lXxAO2cKz6fD7WZa4tMF+uwe2iijIhrVz5jbxY1ideuRBsiQRQ==
X-Received: by 10.28.158.74 with SMTP id h71mr15165870wme.74.1453153698575;
        Mon, 18 Jan 2016 13:48:18 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id e9sm25614967wjp.18.2016.01.18.13.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 13:48:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqoacid4zh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284326>

On 01/18, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > +--symrefs::
> > +	Show the symrefs in addition to the other refs.
> > +
>
> Micronit.  The above sounds as if the output would not talk about
> HEAD at all unless this option is given, which is not what you meant
> here.  "In addition to the object pointed by it, show the underlying
> ref pointed by it when showing a symbolic ref" or something like that,
> perhaps?

Thanks, that sounds better, will change.

> > @@ -58,6 +60,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> >  			 N_("take url.<base>.insteadOf into account")),
> >  		OPT_SET_INT(0, "exit-code", &status,
> >  			    N_("exit with exit code 2 if no matching refs are found"), 2),
> > +		OPT_BOOL(0, "symrefs", &symrefs, N_("show symrefs")),
>
> Likewise.
>
> By the way, unlike "--heads" and "--tags", which is to choose a
> group of refs to be shown, this controls one specific aspect,
> i.e. target of symbolic ref, of each thing that is being shown,
> without affecting the set of refs that the command talks about.
>
> Shouldn't this option be "--symref" (and variable named as
> show_symref_target or something more explicit)?

The change of the variable name definitely makes sense.  My thoughts
were that potentially multiple symrefs are shown, so the plural would
make sense, but after reading your explanation I think I agree with
using --symref as the name.  Thanks.

> Other than these nits, the code itself looks good.
>
> Thanks.
>

--
Thomas

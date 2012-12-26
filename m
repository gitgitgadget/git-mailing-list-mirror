From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 10/14] For each exclude pattern, store information
 about where it came from
Date: Wed, 26 Dec 2012 15:46:17 +0000
Message-ID: <CAOkDyE-HEAiBPyLLTRs2gY1C9uBSmX+xG6NqzLeoWh-oYb0LUA@mail.gmail.com>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
	<1348170383-15751-1-git-send-email-git@adamspiers.org>
	<1348170383-15751-11-git-send-email-git@adamspiers.org>
	<7vzk4k8joy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 26 16:46:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TntBo-0004QD-27
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 16:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab2LZPqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 10:46:20 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:52242 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab2LZPqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 10:46:19 -0500
Received: by mail-wi0-f179.google.com with SMTP id o1so4885023wic.0
        for <git@vger.kernel.org>; Wed, 26 Dec 2012 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=ibPWm0ol2XdIwLBoVzaikFN2B0poFSQpX86y6imRnPE=;
        b=QykN/vVCCXehLXXMFB7Hys4FsBgfVrdbsmxTsOBGfrAgiUUb3bZlwzTsBBQ53vxOhH
         oFNHyZVuUfkz1W0nGgi8XD18virwfsioaEu4kTbUUDRMOT9tmIHVAj8nRAlGzoNA54SY
         ZhGdDdxn99V/tJXIeZcBQ+gWIuZOklRaDckh5QSG2Z1EwqJP/osBhr81Ejm81eEbCHyh
         1keTL9bPFcJ7WYpBiZeIyzJsvPjzDCjxGnPv8TcgjxBHYQG+TEBTfj1SV6hjjkIVvfiP
         6JUiHEL+Wux1o/ntz8PdwzspfHM+T8xZx/JUCaR09JNenQ1qkuSNMXOKH5uaC12KqxkK
         Nd3w==
Received: by 10.194.85.234 with SMTP id k10mr44527275wjz.53.1356536777984;
 Wed, 26 Dec 2012 07:46:17 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Wed, 26 Dec 2012 07:46:17 -0800 (PST)
In-Reply-To: <7vzk4k8joy.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: WLGTJvOSl3PN-WwZb7Lhsu9m8tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212138>

On Thu, Sep 20, 2012 at 02:31:57PM -0700, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
> >  void add_exclude(const char *string, const char *base,
> > -		 int baselen, struct exclude_list *el)
> > +		 int baselen, struct exclude_list *el, const char *src, int srcpos)
> >  {
> >  	struct exclude *x;
> >  	size_t len;
> > @@ -341,6 +341,8 @@ void add_exclude(const char *string, const char *base,
> >  	x->base = base;
> >  	x->baselen = baselen;
> >  	x->flags = flags;
> > +	x->src = src;
> > +	x->srcpos = srcpos;
>
> Hrm, don't all elements "x" in "el" share the same "src", even if
> their srcpos may be different?

No not currently - please see the other mail I just sent to the
[PATCH v2 00/14] thread.

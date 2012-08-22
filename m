From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 19:41:07 +0200
Message-ID: <503519B3.1020403@kdbg.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org> <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> <7vy5l9lj6m.fsf@alter.siamese.dyndns.org> <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de> <7v4nnxld24.fsf@alter.siamese.dyndns.org> <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de> <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:41:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Evg-0007DY-89
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab2HVRlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:41:15 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:58099 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752193Ab2HVRlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:41:13 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D1472CDF8B;
	Wed, 22 Aug 2012 19:41:07 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1BE2219F3C6;
	Wed, 22 Aug 2012 19:41:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204045>

Am 22.08.2012 19:00, schrieb Brandon Casey:
>  So I think the body of [compat_mkdir] can become
> something like:
> 
>    if (len && dir[len-1] == '/')
>        dir = tmp_dir = xstrndup(dir, len-1);

Don't use x* wrappers in the compat layer, at least not those that
allocate memory: They behave unpredictably due to try_to_free_routine
and may lead to recursive invocations.

> 
>    retval = mkdir(dir, mode);
>    free(tmp_dir);

-- Hannes

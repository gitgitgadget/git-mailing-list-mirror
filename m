From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3 5/6] config: select .git/common/config with --repo
Date: Sun, 31 Jan 2016 00:10:10 +0200
Message-ID: <20160130221010.GD4978@wheezy.local>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	max@max630.net, git@drmicha.warpmail.net, Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 23:11:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPdjN-0004ax-8R
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 23:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299AbcA3WKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2016 17:10:15 -0500
Received: from p3plsmtpa07-10.prod.phx3.secureserver.net ([173.201.192.239]:45894
	"EHLO p3plsmtpa07-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754112AbcA3WKO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2016 17:10:14 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-10.prod.phx3.secureserver.net with 
	id CNA81s00A5B68XE01NABdz; Sat, 30 Jan 2016 15:10:13 -0700
Content-Disposition: inline
In-Reply-To: <1453808685-21235-6-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285128>

On Tue, Jan 26, 2016 at 06:44:44PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> This new option allows the user to write to or read from
> .git/common/config in worktree v1. In worktree v0, --repo is an alias
> of --local.

Looks like by default a value is always set in a local
config, which might be dangerous for remote.* or gc.*
parameters, for example. I think that even if reading is
done uniformly setting could depend on the actual variable
being set if no location specified.

>  	if (use_global_config + use_system_config + use_local_config +
> -	    !!given_config_source.file + !!given_config_source.blob > 1) {
> +	    !!given_config_source.file + !!given_config_source.blob > 1 +
> +	    use_repo_config) {
>  		error("only one config file at a time.");

Shouldn't "+ use_repo_config" do here to the left part of
comparison?

--=20
Max

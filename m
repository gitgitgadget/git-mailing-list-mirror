From: Kevin Daudt <me@ikke.info>
Subject: Re: question about resume support.
Date: Sun, 22 Feb 2015 16:53:12 +0100
Message-ID: <20150222155312.GA7906@vps892.directvps.nl>
References: <20150221200127.4ade03ad@archus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "drathir87@gmail.com" <drathir87@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 17:00:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPYxL-0001V4-RP
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 17:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbbBVQAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2015 11:00:22 -0500
Received: from ikke.info ([178.21.113.177]:51340 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbbBVQAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2015 11:00:21 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Feb 2015 11:00:21 EST
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 2E43F1DCF6D; Sun, 22 Feb 2015 16:53:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150221200127.4ade03ad@archus>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264231>

On Sat, Feb 21, 2015 at 08:01:27PM +0100, drathir87@gmail.com wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Hi... Im wonder there is planned or maybe there is support of resuming
> interrupted git operation e.g. cloning repositories? Not sure about how
> hard that could be to implement, but greatly should decrease of
> bandwidth used by persons with weak network connection...
> -----BEGIN PGP SIGNATURE-----
> 
> iQJ8BAEBCgBmBQJU6NYHXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
> ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRFMEZBMTE5Mjc5MTM0QTZFNDdGRTk3MEZB
> RUEzMzk3NTlGNjNCMEZDAAoJEK6jOXWfY7D8CXsP/37F3cHNVgrNj+xzeR1H38xQ
> q5zSLNMUYr771gUXBac/p8MfDYlS7gKwRV4Bxhl8AmfH9q28ybj4UFp+5A9u1mKF
> E4rrMJE4mrwf/dOeYHMd4EK7aCFrEl9DVnD6uXlQ+QC6qQ23LyR2WHVX3u1a6EQV
> tsFIuGLh1kBATWt2/Fim60BqI6P3/PX0gB2R+gPdnm5vG3cY5iNSw/UgZUbRNmMa
> QgzBwpxNOTqlJ3GQ9cWgL5CH83VrFmjqHqa8xbVd2ATVaWXTk4pDJFBBafSNJg8s
> RMumCGpWmMYBEtAJY/UgE32F2ms7ravLOY0hj9PCoW0FH+czdI9ZNQ8jvdThMByp
> +6mHqU2SyYoetnBclcgSrOMdkiCivWB7GaOBscA5E1MM3FpQBdJSBrDlq5yhs9WG
> uKhyBpts9+9IdiUPvd4ej4CVXXsE9/FKAEK7+ilr7HsLbRr0vXeAiWA7q+k+Avce
> Ih8nwt9onAM37OH7BoW8va/4g/3yHr9EaYFg7ea9hJYUomVY3l/mIQxeG+KPFZnC
> XnCVAEMSeMujwjIKqHUEWS8RuHOlxS+q8TEZS7caR/8ausondbQuYK4HLsVhiwFZ
> AklwtLBmoIR2yNFn+NKfDOw1RWPsvHSN7yKEQIe+SdUEDDS8QvhfCeKDVSD77ezX
> BpXSPfNLMDYqZNp5f+NB
> =+Bnw
> -----END PGP SIGNATURE-----

While not the best solution, what's currently possible is to provide an
initial git bundle that is regularly updated which can be downloaded
through other protocols that do provide resumption. Users can use that
to setup the repository, and then use the normal git protocol to get the
latest updates.

The reason this is not easy to facilitate is that the packs git
generates are only generated in-memory. These packs would need to be
cached on disk and somehow have a mapping to the user that downloaded
that pack. Also there would need to be some kind of way to expire these
cached packs. The protocol would need to be updated to indicate a users
wants to resume a clone (or fetch) and what parts are still missing, and
probably lots of other details I'm missing.

Kevin
